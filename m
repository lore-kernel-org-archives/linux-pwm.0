Return-Path: <Li.Xiubo@freescale.com>
From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv6 0/4] Add Freescale FTM PWM driver.
Date: Fri, 22 Nov 2013 07:18:54 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828C7A6E@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: Li.Xiubo@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Hi Thierry,

Could you help review this series of patches please ?=20

And could it be merged into the PWM next tree?

Thanks very much.

--


> Subject: [PATCHv6 0/4] Add Freescale FTM PWM driver.
>=20
> Hello Thierry,
>=20
> The series of patches for this version has been reviewed and acked
> already.
> To see each patch for detail.
>=20
>=20
> ------------------
> ------------------
>=20
> This patch series is the Freescale FTM PWM implementation. And there are
> 8 channels most supported by the FTM PWM. This implementation is only
> compatible with device tree definition.
>=20
> This patch series is based on linux-next and has been tested on Vybrid
> VF610 Tower board using device tree.
>=20
>=20
>=20
> Changes in v6:
> - Nothing.
>=20
> Changes in RFCv2 of PATVHv5:
> - Remove "fsl,pwm-counter-clk".
>=20
> Changes in v5:
> - Remove active/idle pinctrl stuff.
>=20
> Changes in v4:
> - Check for the result and return an error for devm_kzalloc().
> - Move pinmux setting from the SoC file to the board specific file.
> - Revise the written mistake of 'ret |=3D FTMSC_CLKEXT;' --> 'reg |=3D
> FTMSC_CLKEXT;'.
>=20
>=20
> Changes in v3:
> - Remove "availabe" field.
> - Remove "fsl,pwm-avaliable-chs" property.
> - ...
>=20
> Changes in v2:
> - Remove PWM CPWM/EPWM feature and sysfs.
> - Remove some redundant code.
> - Revise some code for more readable.
> - Remove "fsl,pwm-clk-ps", "fsl,pwm-number", "fsl,pwm-channels",etc.
> - Add "fsl,pwm-avaliable-chs", "fsl,pwm-counter-clk", etc.
> - Support 8 channels default in dtsi file.
> - Add counter clock source selection.
> - Rename some function name, macro name, etc.
> - Use PWM's and OF's existing function interfaces.
> - Split clk_unprepare_enable to clk_unprepare and clk_enable,etc.
> - ...
>=20
> Added in v1:
> - Add Freescale FTM PWM driver support.
> - Add Freescale FTM PWM node for VF610.
> - Enable Enables FTM PWM device for Vybrid VF610 TOWER.
> - Add device tree bindings for Freescale.
>=20
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
