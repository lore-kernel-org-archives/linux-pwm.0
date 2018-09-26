From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 0/3] treewide: add vibrator support for various MSM SOCs
Date: Wed, 26 Sep 2018 19:51:09 -0400
Message-ID: <20180926235112.25710-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: masneyb@onstation.org, jonathan@marek.ca, ctatlor97@gmail.com
List-Id: linux-pwm@vger.kernel.org

This patch set adds support for the vibrator found on various Qualcomm
MSM SOCs. This is based on work from:

Jonathan Marek from qcom,pwm-vibrator.c in the PostmarketOS repo:
https://gitlab.com/postmarketOS/linux-postmarketos/commit/7647fb36cb1cbd060f8b52087a68ab93583292b5

Jongrak Kwon and Devin Kim from msm_pwm_vibrator.c in the downstream
Android 3.4.0 sources:
https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-lollipop-wear-release/drivers/misc/msm_pwm_vibrator.c

Driver was tested on a LG Nexus 5 (hammerhead) phone using rumble-test:
https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

Changes since v1
- Update device tree binding document based on feedback from Rob
  Herring.
- Changed the driver description to: Qualcomm PWM driver for the MSM
  vibrator.

Brian Masney (3):
  dt-bindings: pwm: msm-vibrator: new bindings for MSM vibrator PWM
  pwm: msm-vibrator: new driver for the vibrator found on various MSM
    SOCs
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    vibrator

 .../bindings/pwm/pwm-msm-vibrator.txt         |  38 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  39 +++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-msm-vibrator.c                | 227 ++++++++++++++++++
 5 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
 create mode 100644 drivers/pwm/pwm-msm-vibrator.c

-- 
2.17.1
