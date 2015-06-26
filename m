From: Shobhit Kumar <shobhit.kumar@intel.com>
Subject: [v3 3/7] mfd: intel_soc_pmic_crc: Add PWM cell device for Crystalcove PMIC
Date: Fri, 26 Jun 2015 14:32:06 +0530
Message-ID: <1435309330-50725-4-git-send-email-shobhit.kumar@intel.com>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10257 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbbFZJCl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 26 Jun 2015 05:02:41 -0400
In-Reply-To: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, varkabhadram@gmail.com, Shobhit Kumar <shobhit.kumar@intel.com>

Needed for PWM control suuported by the PMIC

CC: Samuel Ortiz <sameo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
---
v2: Correct the subject line (Lee jones)

 drivers/mfd/intel_soc_pmic_crc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_p=
mic_crc.c
index 7436075..4a74948 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -109,6 +109,9 @@ static struct mfd_cell crystal_cove_dev[] =3D {
 	{
 		.name =3D "crystal_cove_pmic",
 	},
+	{
+		.name =3D "crystal_cove_pwm",
+	},
 };
=20
 static const struct regmap_config crystal_cove_regmap_config =3D {
--=20
1.9.1
