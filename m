Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 11/11] arm/arm64: defconfig: Update configs to use the new CROS_EC options
Date: Tue, 25 Jun 2019 11:38:19 +0200
Message-Id: <20190625093819.10190-12-enric.balletbo@collabora.com>
In-Reply-To: <20190625093819.10190-1-enric.balletbo@collabora.com>
References: <20190625093819.10190-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, gwendal@chromium.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com

Recently we refactored the CrOS EC drivers moving part of the code from
the MFD subsystem to the platform chrome subsystem. During this change
we needed to rename some config options, so, update the defconfigs
accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v3: None
Changes in v2: None

 arch/arm/configs/exynos_defconfig   | 4 +++-
 arch/arm/configs/multi_v7_defconfig | 6 ++++--
 arch/arm/configs/pxa_defconfig      | 4 +++-
 arch/arm64/configs/defconfig        | 6 ++++--
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c95c54284da2..03448fba569f 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -154,7 +154,9 @@ CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
-CONFIG_MFD_CROS_EC=y
+CONFIG_MFD_CROS_EC_DEV=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_MFD_MAX14577=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6b748f214eae..9fe783abf3c5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -510,10 +510,12 @@ CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
-CONFIG_MFD_CROS_EC=m
+CONFIG_MFD_CROS_EC_DEV=m
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=m
 CONFIG_CROS_EC_I2C=m
 CONFIG_CROS_EC_SPI=m
-CONFIG_MFD_CROS_EC_CHARDEV=m
+CONFIG_CROS_EC_CHARDEV=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 07ebbdce3645..e335b986cf70 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -394,7 +394,9 @@ CONFIG_SA1100_WATCHDOG=m
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_BCM590XX=m
 CONFIG_MFD_AXP20X=y
-CONFIG_MFD_CROS_EC=m
+CONFIG_MFD_CROS_EC_DEV=m
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=m
 CONFIG_CROS_EC_I2C=m
 CONFIG_CROS_EC_SPI=m
 CONFIG_MFD_ASIC3=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..b5bba5f04082 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -430,8 +430,7 @@ CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
-CONFIG_MFD_CROS_EC=y
-CONFIG_MFD_CROS_EC_CHARDEV=m
+CONFIG_MFD_CROS_EC_DEV=y
 CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
@@ -631,8 +630,11 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_XEN_GNTDEV=y
 CONFIG_XEN_GRANT_DEV_ALLOC=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
 CONFIG_CROS_EC_SPI=y
+CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
-- 
2.20.1
