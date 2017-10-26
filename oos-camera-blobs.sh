#!/bin/bash

# Old camera HAL blobs
libs=" \
vendor/lib/libjpegdhw.so
vendor/lib/libjpegehw.so
vendor/lib/libmmcamera2_c2d_module.so
vendor/lib/libmmcamera2_cpp_module.so
vendor/lib/libmmcamera2_frame_algorithm.so
vendor/lib/libmmcamera2_iface_modules.so
vendor/lib/libmmcamera2_imglib_modules.so
vendor/lib/libmmcamera2_is.so
vendor/lib/libmmcamera2_isp_modules.so
vendor/lib/libmmcamera2_pproc_modules.so
vendor/lib/libmmcamera2_q3a_core.so
vendor/lib/libmmcamera2_sensor_modules.so
vendor/lib/libmmcamera2_stats_algorithm.so
vendor/lib/libmmcamera2_stats_modules.so
vendor/lib/libmmcamera2_vpe_module.so
vendor/lib/libmmcamera2_wnr_module.so
vendor/lib/libmmcamera_cac_lib.so
vendor/lib/libmmcamera_faceproc.so
vendor/lib/libmmcamera_hdr_gb_lib.so
vendor/lib/libmmcamera_hdr_lib.so
vendor/lib/libmmcamera_imglib.so
vendor/lib/libmmcamera_ov8858.so
vendor/lib/libmmcamera_pdaf.so
vendor/lib/libmmcamera_pdafcamif.so
vendor/lib/libmmcamera_s5k3m2.so
vendor/lib/libmmcamera_sunny_f13s01l_eeprom.so
vendor/lib/libmmcamera_sunny_p8v12b_eeprom.so
vendor/lib/libmmcamera_tintless_algo.so
vendor/lib/libmmcamera_tintless_bg_pca_algo.so
vendor/lib/libmmcamera_wavelet_lib.so
vendor/lib/libmmipl.so
vendor/lib/libmmjpeg.so
vendor/lib/libmmqjpeg_codec.so
vendor/lib/liboemcamera.so
vendor/lib/libqomx_jpegdec.so
vendor/lib/libqomx_jpegenc.so
vendor/lib/libactuator_dw9800w.so
vendor/lib/libactuator_dw9800w_camcorder.so
vendor/lib/libactuator_dw9800w_camera.so
vendor/lib/libchromatix_ov8858_common.so
vendor/lib/libchromatix_ov8858_default_video.so
vendor/lib/libchromatix_ov8858_liveshot.so
vendor/lib/libchromatix_ov8858_preview.so
vendor/lib/libchromatix_ov8858_preview_binding.so
vendor/lib/libchromatix_ov8858_small_video.so
vendor/lib/libchromatix_ov8858_snapshot.so
vendor/lib/libchromatix_s5k3m2_common.so
vendor/lib/libchromatix_s5k3m2_default_video.so
vendor/lib/libchromatix_s5k3m2_hfr_120fps.so
vendor/lib/libchromatix_s5k3m2_hfr_60fps.so
vendor/lib/libchromatix_s5k3m2_hfr_90fps.so
vendor/lib/libchromatix_s5k3m2_liveshot.so
vendor/lib/libchromatix_s5k3m2_preview.so
vendor/lib/libchromatix_s5k3m2_snapshot.so
vendor/lib/libchromatix_s5k3m2_zsl.so"

bins="vendor/bin/mm-qcamera-daemon"

fmws=" \
etc/firmware/cpp_firmware_v1_1_1.fw
etc/firmware/cpp_firmware_v1_1_6.fw
etc/firmware/cpp_firmware_v1_2_0.fw"

root="/root/proprietary_vendor_oneplus/"
url="https://raw.githubusercontent.com/TheMuppets/proprietary_vendor_oneplus/lineage-15.0/"

binarr=(${bins})
libarr=(${libs})
fmwarr=(${fmws})
retarr=(${binarr[@]}" "${libarr[@]}" "${fmwarr[@]})

# Remove old camera HAL blobs
for i in ${retarr[@]}
do
	rm -rf ${root}"onyx/proprietary/"${i}
	str=${i//\//\\\/}
	# echo $str
	sed "/${str}/d" -i ${root}"onyx/onyx-vendor.mk"
done


# New camera HAL blobs
libs="\
lib/libFNVfbEngineLib.so
lib/libopcamerahw_interface.so
vendor/lib/libjpegdhw.so
vendor/lib/libjpegehw.so
vendor/lib/libmmcamera2_c2d_module.so
vendor/lib/libmmcamera2_cpp_module.so
vendor/lib/libmmcamera2_frame_algorithm.so
vendor/lib/libmmcamera2_iface_modules.so
vendor/lib/libmmcamera2_imglib_modules.so
vendor/lib/libmmcamera2_is.so
vendor/lib/libmmcamera2_isp_modules.so
vendor/lib/libmmcamera2_pproc_modules.so
vendor/lib/libmmcamera2_q3a_core.so
vendor/lib/libmmcamera2_sensor_modules.so
vendor/lib/libmmcamera2_stats_algorithm.so
vendor/lib/libmmcamera2_stats_modules.so
vendor/lib/libmmcamera2_vpe_module.so
vendor/lib/libmmcamera2_wnr_module.so
vendor/lib/libmmcamera_cac_lib.so
vendor/lib/libmmcamera_dw9761b_eeprom.so
vendor/lib/libmmcamera_faceproc.so
vendor/lib/libmmcamera_hdr_gb_lib.so
vendor/lib/libmmcamera_hdr_lib.so
vendor/lib/libmmcamera_imglib.so
vendor/lib/libmmcamera_imx214.so
vendor/lib/libmmcamera_ofilm_oty5f03_eeprom.so
vendor/lib/libmmcamera_ov5648.so
vendor/lib/libmmcamera_ov8858.so
vendor/lib/libmmcamera_pdaf.so
vendor/lib/libmmcamera_pdafcamif.so
vendor/lib/libmmcamera_s5k3l8.so
vendor/lib/libmmcamera_s5k3m2.so
vendor/lib/libmmcamera_sunny_f13s01l_eeprom.so
vendor/lib/libmmcamera_sunny_p12v01m_eeprom.so
vendor/lib/libmmcamera_sunny_p5v23c_eeprom.so
vendor/lib/libmmcamera_sunny_p8v12b_eeprom.so
vendor/lib/libmmcamera_sunny_q8v18a_eeprom.so
vendor/lib/libmmcamera_tintless_algo.so
vendor/lib/libmmcamera_tintless_bg_pca_algo.so
vendor/lib/libmmcamera_truly_cm7700_eeprom.so
vendor/lib/libmmcamera_wavelet_lib.so
vendor/lib/libmmipl.so
vendor/lib/libmmjpeg.so
vendor/lib/libmmqjpeg_codec.so
vendor/lib/liboemcamera.so
vendor/lib/libactuator_dw9714.so
vendor/lib/libactuator_dw9714_camcorder.so
vendor/lib/libactuator_dw9714_camera.so
vendor/lib/libactuator_dw9800w.so
vendor/lib/libactuator_dw9800w_camcorder.so
vendor/lib/libactuator_dw9800w_camera.so
vendor/lib/libchromatix_ov8858_common.so
vendor/lib/libchromatix_ov8858_default_video.so
vendor/lib/libchromatix_ov8858_liveshot.so
vendor/lib/libchromatix_ov8858_preview.so
vendor/lib/libchromatix_ov8858_preview_binding.so
vendor/lib/libchromatix_ov8858_small_video.so
vendor/lib/libchromatix_ov8858_snapshot.so
vendor/lib/libchromatix_s5k3m2_common.so
vendor/lib/libchromatix_s5k3m2_common_panorama.so
vendor/lib/libchromatix_s5k3m2_default_video.so
vendor/lib/libchromatix_s5k3m2_hfr_120fps.so
vendor/lib/libchromatix_s5k3m2_hfr_60fps.so
vendor/lib/libchromatix_s5k3m2_hfr_90fps.so
vendor/lib/libchromatix_s5k3m2_liveshot.so
vendor/lib/libchromatix_s5k3m2_preview.so
vendor/lib/libchromatix_s5k3m2_preview_panorama.so
vendor/lib/libchromatix_s5k3m2_snapshot.so
vendor/lib/libchromatix_s5k3m2_snapshot_panorama.so
vendor/lib/libchromatix_s5k3m2_video_hd.so
vendor/lib/libchromatix_s5k3m2_zsl.so
vendor/lib/libqomx_jpegdec.so
vendor/lib/libqomx_jpegenc.so"

bins="bin/mm-qcamera-daemon"

fmws=" \
etc/firmware/cpp_firmware_v1_1_1.fw
etc/firmware/cpp_firmware_v1_1_6.fw
etc/firmware/cpp_firmware_v1_2_0.fw"

binarr=(${bins})
libarr=(${libs})
fmwarr=(${fmws})
retarr=(${binarr[@]}" "${libarr[@]}" "${fmwarr[@]})

# echo ${retarr[@]}

# Remove old camera HAL blobs
for i in ${retarr[@]}
do
	cd $root
	if [[ $i =~ "bin" ]]
	then
		if [ ! -d "onyx/proprietary/bin" ]
		then
			/usr/bin/mkdir "onyx/proprietary/bin"
		fi
	fi
	echo ${url}"onyx/proprietary/"${i}
	wget -qO "onyx/proprietary/"$i ${url}"onyx/proprietary/"${i}
done
