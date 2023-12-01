# -*- coding: utf-8 -*-
# _____________________________________________________________________________
# _____________________________________________________________________________
#
#                       Coded by: Daniel Gonzalez-Duque
#                               Last revised 2023-12-01
# _____________________________________________________________________________
# _____________________________________________________________________________
"""
______________________________________________________________________________

 DESCRIPTION:
   This script creates a map of the projected flood risk in the US. Keep in mind
   that the data used for plotting is heavy and might take some time to load and
   plot.

   The data source comes from the CEJST project. The data is available at:

   White House Council on Environmental Quality. (2022). Climate and Economic
   Justice Screening Tool. Retrieved November 30, 2023, from
   https://screeningtool.geoplatform.gov

   Additional information for the plot was generated and saved in the following 
   Google Drive folder:

   https://drive.google.com/drive/folders/1-TQDe8FUGF3rD_C3-nzxkJVV4uiuI6w0?usp=sharing

   Please make sure to have all of the packages installed before running the
   code and also correct the path to the data in your computer.
______________________________________________________________________________
"""
# ----------------
# Import packages
# ----------------
import numpy as np
import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
import matplotlib as mpl
import seaborn as sns
# ------------------
# Directories
# ------------------
path_cejst = f'data/00_raw/CEJST/'
# ------------------------
# Load Datasets
# ------------------------
# Load Shapefile of US with geopandas
shp_us = f'{path_cejst}/1.0-shapefile-codebook/usa/usa.shp'
shapefile = gpd.read_file(shp_us)
# Load dataset Census tract 2010 ID must be string
df = pd.read_csv(f'{path_cejst}1.0-communities.csv',
                 dtype={'Census tract 2010 ID': str})
# df = pd.read_csv(f'{path_cejst}1.0-communities.csv', )
columns = df.columns.values

flood_columns = [
    col for col in df.columns if 'flood' in col.lower()] + [
        'Census tract 2010 ID', 'Total population']

# Clip dataset to flood columns
flood_df = df[flood_columns]

# merge shapefile with dataset
shapefile_flood = shapefile.merge(
    flood_df, how='left', left_on='GEOID10', right_on='Census tract 2010 ID')

# Loading Contour Shapefile
shp_usa_st_file = f'{path_cejst}/shapefiles/USA_States.shp'
shp_usa_st = gpd.read_file(shp_usa_st_file)
shp_sw_contour_file = f'{path_cejst}/shapefiles/South_West_Countour.shp'
shp_sw = gpd.read_file(shp_sw_contour_file)
shp_sw_st_file = f'{path_cejst}/shapefiles/South_West_States.shp'
shp_sw_st = gpd.read_file(shp_sw_st_file)
shp_tn_contour_file = f'{path_cejst}/shapefiles/Tennessee_Contour.shp'
shp_tn = gpd.read_file(shp_tn_contour_file)
shp_tn_c_file = f'{path_cejst}/shapefiles/Tennessee_Counties.shp'
shp_tn_c = gpd.read_file(shp_tn_c_file)
shp_dc_contour_file = f'{path_cejst}/shapefiles/Davidson_County_Contour.shp'
shp_dc = gpd.read_file(shp_dc_contour_file)

# ------------------------
# Extract data
# ------------------------
shp_flood_low_income_90 = shapefile_flood[shapefile_flood[flood_columns[3]] == 1]
f_90_low_income_flag = shapefile_flood[flood_columns[3]].values

# South West
sw_flood = shapefile_flood[
    (shapefile_flood['SF'] == 'Kentucky') |
    (shapefile_flood['SF'] == 'Tennessee') |
    (shapefile_flood['SF'] == 'Mississippi') |
    (shapefile_flood['SF'] == 'Alabama') |
    (shapefile_flood['SF'] == 'Florida') |
    (shapefile_flood['SF'] == 'Georgia') |
    (shapefile_flood['SF'] == 'South Carolina') |
    (shapefile_flood['SF'] == 'North Carolina')
    ]
sw_flood_low_income_90 = sw_flood[sw_flood[flood_columns[3]] == 1]

# Tennessee
tn_flood = shapefile_flood[
    (shapefile_flood['SF'] == 'Tennessee')
    ]
tn_flood_low_income_90 = tn_flood[tn_flood[flood_columns[3]] == 1]

dc_flood = tn_flood[(tn_flood['CF'] == 'Davidson County')]
dc_flood_low_income_90 = dc_flood[dc_flood[flood_columns[3]] == 1]

# Extract proportions of flood risk higher than 90%
# USA
flood_usa_prop = shapefile_flood[flood_columns[-1]].values
flood_usa_90 = shapefile_flood[flood_columns[2]].values
flood_usa_90_li = shapefile_flood[flood_columns[3]].values
flood_usa_prop_90 = np.nansum(flood_usa_prop[flood_usa_90 == 1])
flood_usa_prop_90_per = flood_usa_prop_90/np.nansum(flood_usa_prop) * 100
flood_usa_prop_90_li = np.nansum(flood_usa_prop[flood_usa_90_li == 1])
flood_usa_prop_90_li_per = flood_usa_prop_90_li/np.nansum(flood_usa_prop) * 100

# South West
flood_sw_prop = sw_flood[flood_columns[-1]].values
flood_sw_90 = sw_flood[flood_columns[2]].values
flood_sw_90_li = sw_flood[flood_columns[3]].values
flood_sw_prop_90 = np.nansum(flood_sw_prop[flood_sw_90 == 1])
flood_sw_prop_90_per = flood_sw_prop_90/np.nansum(flood_sw_prop) * 100
flood_sw_prop_90_li = np.nansum(flood_sw_prop[flood_sw_90_li == 1])
flood_sw_prop_90_li_per = flood_sw_prop_90_li/np.nansum(flood_sw_prop) * 100

# Tennessee
flood_tn_prop = tn_flood[flood_columns[-1]].values
flood_tn_90 = tn_flood[flood_columns[2]].values
flood_tn_90_li = tn_flood[flood_columns[3]].values
flood_tn_prop_90 = np.nansum(flood_tn_prop[flood_tn_90 == 1])
flood_tn_prop_90_per = flood_tn_prop_90/np.nansum(flood_tn_prop) * 100
flood_tn_prop_90_li = np.nansum(flood_tn_prop[flood_tn_90_li == 1])
flood_tn_prop_90_li_per = flood_tn_prop_90_li/np.nansum(flood_tn_prop) * 100

# Davidson County
flood_dc_prop = dc_flood[flood_columns[-1]].values
flood_dc_90 = dc_flood[flood_columns[2]].values
flood_dc_90_li = dc_flood[flood_columns[3]].values
flood_dc_prop_90 = np.nansum(flood_dc_prop[flood_dc_90 == 1])
flood_dc_prop_90_per = flood_dc_prop_90/np.nansum(flood_dc_prop) * 100
flood_dc_prop_90_li = np.nansum(flood_dc_prop[flood_dc_90_li == 1])
flood_dc_prop_90_li_per = flood_dc_prop_90_li/np.nansum(flood_dc_prop) * 100

# ==========================
# Plotting
# ==========================
fs = 12
mpl.rcParams['font.size'] = fs
mpl.rcParams['font.family'] = 'Avenir'
fig, ax = plt.subplots(1, 1, figsize=(10, 5))
# ------------------------
# Include colorbar
# ------------------------
ax_cbar = fig.add_axes([0.92, 0.1, 0.02, 0.8])
# ------------------------
# Whole USA
# ------------------------
shapefile_flood.plot(column=flood_columns[0], ax=ax,
                     cmap='YlGnBu', edgecolor='black', linewidth=0.01,
                     vmin=0, vmax=100, legend=True, cax=ax_cbar,
                     legend_kwds={'label': 'Flood Risk (%)',
                                  'orientation': 'vertical'})
shp_flood_low_income_90.plot(ax=ax, color='none', edgecolor='#9E681C',
                             linewidth=0.5, hatch='xxx')
shp_usa_st.plot(ax=ax, color='none', edgecolor='black', linewidth=1)
shp_sw.plot(ax=ax, color='none', edgecolor='red', linewidth=1)
# Plot low income as contour
ax.set_xlim([-130, -60])
ax.set_ylim([20, 55])
ax.axis('off')
# Move Figure
# get position of the axes
pos1 = ax.get_position()
# Move
minus = 0.06
ax.set_position([
    0.005, 0.34, pos1.width - minus, pos1.height - minus])
# ------------------------
# South West
# ------------------------
ax_sw = fig.add_axes([0.42, 0.38, 0.53, 0.53])
sw_flood.plot(column=flood_columns[0], ax=ax_sw,
              cmap='YlGnBu', edgecolor='black', linewidth=0.01,
              vmin=0, vmax=100)
shp_sw_st.plot(ax=ax_sw, color='none', edgecolor='black', linewidth=1)
sw_flood_low_income_90.plot(ax=ax_sw,
                            cmap='YlGnBu', edgecolor='#9E681C', linewidth=0.5,
                            color='none', hatch='xxx')
shp_tn.plot(ax=ax_sw, color='none', edgecolor='red', linewidth=1)
# Draw Line from ax to ax_sw
ax_sw.axis('off')
# ------------------------
# Tennessee
# ------------------------
ax_tn = fig.add_axes([0.44, 0.01, 0.5, 0.5])
tn_flood.plot(column=flood_columns[0], ax=ax_tn,
                cmap='YlGnBu', edgecolor='black', linewidth=0.01,
                vmin=0, vmax=100)
shp_tn_c.plot(ax=ax_tn, color='none', edgecolor='black', linewidth=1)
tn_flood_low_income_90.plot(ax=ax_tn,
                            cmap='YlGnBu', edgecolor='#9E681C', linewidth=0.5,
                            color='none', hatch='xxx')
shp_dc.plot(ax=ax_tn, color='none', edgecolor='red', linewidth=1)
ax_tn.axis('off')
# ---------------------------------
# Bar plot of percentage per map
# ---------------------------------
ax_dc = fig.add_axes([0.08, 0.05, 0.35, 0.28])
sns.barplot(
    x=['US', 'SW US', 'TN', 'DC'],
    y=[flood_usa_prop_90_per, flood_sw_prop_90_per, flood_tn_prop_90_per,
       flood_dc_prop_90_per],
    ax=ax_dc, color='#8DBEB3', label='Overall')
# Hatch low income
ax_dc.bar(
    x=['US', 'SW US', 'TN', 'DC'],
    height=[flood_usa_prop_90_li_per, flood_sw_prop_90_li_per,
            flood_tn_prop_90_li_per, flood_dc_prop_90_li_per],
    color='none', edgecolor='#9E681C', linewidth=0.5, hatch='xxx',
    label='Low Income')
# remove top and right spines
# ax_dc.set_title('Proportion of Flood Risk Larger than 90%')
ax_dc.set_title('Proportion of population in regions \nwith flood risk larger than 90%')
ax_dc.set_ylabel('Percentage (%)')
# plot legend without frame
ax_dc.legend(loc=1, frameon=False)
ax_dc.set_ylim([0, 25])
ax_dc.spines['top'].set_visible(False)
ax_dc.spines['right'].set_visible(False)

# ------------------------
# Final Changes
# ------------------------
# fig.suptitle('Projected Flood Risk in the US', fontsize=16)
fig.suptitle('Share of the properties at risk of flood in 30 years', fontsize=16)
# Include letters
fig.text(0.08, 0.5, '(A)', fontsize=16, weight='bold')
fig.text(0.6, 0.5, '(B)', fontsize=16, weight='bold')
fig.text(0.85, 0.15, '(C)', fontsize=16, weight='bold')
fig.text(0.01, 0.37, '(D)', fontsize=16, weight='bold')

# Draw line between US and South West
# con_max = mpl.patches.ConnectionPatch(
#     xyA=(-84.77, 39.11), xyB=(-84.77, 39.11),
#     coordsA="data", coordsB="data", axesA=ax, axesB=ax_sw,
#     color="red", lw=1)
# con_min = mpl.patches.ConnectionPatch(
#     xyA=(-81.98, 24.46), xyB=(-81.98, 24.46),
#     coordsA="data", coordsB="data", axesA=ax, axesB=ax_sw,
#     color="red", lw=1)
# ax_sw.add_artist(con_max)
# ax_sw.add_artist(con_min)

# # Draw line between South West and Tennessee
# con_max = mpl.patches.ConnectionPatch(
#     xyA=(-89.539, 36.497), xyB=(-89.539, 36.497),
#     coordsA="data", coordsB="data", axesA=ax_sw, axesB=ax_tn,
#     color="red", lw=1)
# con_min = mpl.patches.ConnectionPatch(
#     xyA=(-81.646, 36.611), xyB=(-81.646, 36.611),
#     coordsA="data", coordsB="data", axesA=ax_sw, axesB=ax_tn,
#     color="red", lw=1)
# ax_tn.add_artist(con_max)
# ax_tn.add_artist(con_min)

# Save Figure
plt.savefig('figures/Projected_Flood_Risk.png', dpi=500, format='png')
plt.savefig('figures/Projected_Flood_Risk.jpg', dpi=500, format='jpg')
# plt.savefig('figures/Projected_Flood_Risk.pdf', dpi=500, format='pdf')
plt.close('all')

