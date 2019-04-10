From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V11 0/5] Add i.MX7ULP EVK PWM backlight support
Date: Wed, 10 Apr 2019 01:47:28 +0000
Message-ID: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX7ULP EVK board has MIPI-DSI display, its backlight is supplied by
TPM PWM module, this patch set enables i.MX7ULP TPM PWM driver support
and also add backlight support for MIPI-DSI display.

Changes since V10:
	- ONLY change the pwm driver patch.

Anson Huang (5):
  dt-bindings: pwm: Add i.MX TPM PWM binding
  pwm: Add i.MX TPM PWM driver support
  ARM: imx_v6_v7_defconfig: Add TPM PWM support by default
  ARM: dts: imx7ulp: Add tpm pwm support
  ARM: dts: imx7ulp-evk: Add backlight support

 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  22 +
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  21 +
 arch/arm/boot/dts/imx7ulp.dtsi                     |  10 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-imx-tpm.c                          | 442 +++++++++++++++++++++
 7 files changed, 508 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

-- 
2.7.4
