From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 1/7] atmel-hlcdc: renamed directory to drm/atmel/
Date: Sun, 12 Aug 2018 20:46:23 +0200
Message-ID: <20180812184629.3808-1-sam@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Use vendor name for directory, adding a suitable place
for more atmel DRM drivers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
---
 MAINTAINERS                                                 | 2 +-
 drivers/gpu/drm/Kconfig                                     | 2 +-
 drivers/gpu/drm/Makefile                                    | 2 +-
 drivers/gpu/drm/{atmel-hlcdc => atmel}/Kconfig              | 6 ++++++
 drivers/gpu/drm/{atmel-hlcdc => atmel}/Makefile             | 0
 drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_crtc.c   | 0
 drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.c     | 0
 drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.h     | 0
 drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_output.c | 0
 drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c  | 0
 10 files changed, 9 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/{atmel-hlcdc => atmel}/Kconfig (83%)
 rename drivers/gpu/drm/{atmel-hlcdc => atmel}/Makefile (100%)
 rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_crtc.c (100%)
 rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.c (100%)
 rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.h (100%)
 rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_output.c (100%)
 rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96e98e206b0d..09ce76a9a1dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4681,7 +4681,7 @@ DRM DRIVERS FOR ATMEL HLCDC
 M:	Boris Brezillon <boris.brezillon@bootlin.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-F:	drivers/gpu/drm/atmel-hlcdc/
+F:	drivers/gpu/drm/atmel/atmel-hlcdc*
 F:	Documentation/devicetree/bindings/display/atmel/
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 2a72d2feb76d..4130df0c0dba 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -232,7 +232,7 @@ source "drivers/gpu/drm/cirrus/Kconfig"
 
 source "drivers/gpu/drm/armada/Kconfig"
 
-source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
+source "drivers/gpu/drm/atmel/Kconfig"
 
 source "drivers/gpu/drm/rcar-du/Kconfig"
 
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index ef9f3dab287f..ce9829967128 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -76,7 +76,7 @@ obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
 obj-$(CONFIG_DRM_AST) += ast/
 obj-$(CONFIG_DRM_ARMADA) += armada/
-obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
+obj-$(CONFIG_DRM_ATMEL)	+= atmel/
 obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 obj-y			+= omapdrm/
diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/atmel/Kconfig
similarity index 83%
rename from drivers/gpu/drm/atmel-hlcdc/Kconfig
rename to drivers/gpu/drm/atmel/Kconfig
index 32bcc4bad06a..7cd3862f9d18 100644
--- a/drivers/gpu/drm/atmel-hlcdc/Kconfig
+++ b/drivers/gpu/drm/atmel/Kconfig
@@ -1,6 +1,12 @@
+config DRM_ATMEL
+	bool
+	help
+	  Enable Atmel DRM support
+
 config DRM_ATMEL_HLCDC
 	tristate "DRM Support for ATMEL HLCDC Display Controller"
 	depends on DRM && OF && COMMON_CLK && MFD_ATMEL_HLCDC && ARM
+	select DRM_ATMEL
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
diff --git a/drivers/gpu/drm/atmel-hlcdc/Makefile b/drivers/gpu/drm/atmel/Makefile
similarity index 100%
rename from drivers/gpu/drm/atmel-hlcdc/Makefile
rename to drivers/gpu/drm/atmel/Makefile
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel/atmel_hlcdc_crtc.c
similarity index 100%
rename from drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
rename to drivers/gpu/drm/atmel/atmel_hlcdc_crtc.c
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel/atmel_hlcdc_dc.c
similarity index 100%
rename from drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
rename to drivers/gpu/drm/atmel/atmel_hlcdc_dc.c
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel/atmel_hlcdc_dc.h
similarity index 100%
rename from drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
rename to drivers/gpu/drm/atmel/atmel_hlcdc_dc.h
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel/atmel_hlcdc_output.c
similarity index 100%
rename from drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
rename to drivers/gpu/drm/atmel/atmel_hlcdc_output.c
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel/atmel_hlcdc_plane.c
similarity index 100%
rename from drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
rename to drivers/gpu/drm/atmel/atmel_hlcdc_plane.c
-- 
2.12.0
