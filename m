Return-Path: <B47053@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 0/4] Add Freescale FTM PWM driver.
Date: Fri, 13 Sep 2013 13:58:38 +0800
Message-ID: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Hello,

This patch series is the Freescale FTM PWM implementation. And there are 8 channels most supported by the FTM PWM. This implementation is only compatible with device tree definition.

This patch series is based on linux-next and has been tested on Vybrid VF610 Tower board using device tree.

Changes in v4:
- Check for the result and return an error for devm_kzalloc().
- Move pinmux setting from the SoC file to the board specific file.
- Revise the written mistake of 'ret |= FTMSC_CLKEXT;' --> 'reg |= FTMSC_CLKEXT;'.


Changes in v3:
- Remove "availabe" field.
- Remove "fsl,pwm-avaliable-chs" property.
- ...

Changes in v2:
- Remove PWM CPWM/EPWM feature and sysfs.
- Remove some redundant code.
- Revise some code for more readable.
- Remove "fsl,pwm-clk-ps", "fsl,pwm-number", "fsl,pwm-channels",etc.
- Add "fsl,pwm-avaliable-chs", "fsl,pwm-counter-clk", etc.
- Support 8 channels default in dtsi file.
- Add counter clock source selection.
- Rename some function name, macro name, etc.
- Use PWM's and OF's existing function interfaces.
- Split clk_unprepare_enable to clk_unprepare and clk_enable,etc.
- ...

Added in v1:
- Add Freescale FTM PWM driver support.
- Add Freescale FTM PWM node for VF610.
- Enable Enables FTM PWM device for Vybrid VF610 TOWER.
- Add device tree bindings for Freescale.
