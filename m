From: Shobhit Kumar <shobhit.kumar@intel.com>
Subject: [v2 3/7] mfd: intel_soc_pmic_crc: Add PWM cell device for Crystalcove PMIC
Date: Mon, 22 Jun 2015 16:24:21 +0530
Message-ID: <1434970465-12687-4-git-send-email-shobhit.kumar@intel.com>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, Shobhit Kumar <shobhit.kumar@intel.com>
List-Id: linux-pwm@vger.kernel.org

Needed for PWM control suuported by the PMIC

v2: Correct the subject line (Lee jones)

CC: Samuel Ortiz <sameo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 7436075..4a74948 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -109,6 +109,9 @@ static struct mfd_cell crystal_cove_dev[] = {
 	{
 		.name = "crystal_cove_pmic",
 	},
+	{
+		.name = "crystal_cove_pwm",
+	},
 };
 
 static const struct regmap_config crystal_cove_regmap_config = {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
