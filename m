Return-Path: <B47053@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/4] Add freescale ftm pwm driver for Vybrid VF610 TOWER
Date: Wed, 21 Aug 2013 11:07:38 +0800
Message-ID: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Hello,

This patch series is the freescale ftm pwm implementation.
There are 8 channels most supported by the ftm pwm,
and there are two pwm modes:
- Center-Aligned PWM (CPWM) mode
- Edge-Aligned PWM (EPWM) mode

This implementation is only compatible with device tree definition.

Please feel free to comment the dt bindinds.

This patch series is based on linux-next and has been tested on Vybrid VF610TWR board using device tree.

Best Regards,
Xiubo Li
