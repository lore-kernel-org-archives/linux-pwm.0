From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Convert imx pwm to json-schema
Date: Wed, 27 May 2020 20:47:11 -0600
Message-ID: <20200528024711.GA3265614@bogus>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966EC7122B2BFB9FEEDD74280B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-il1-f194.google.com ([209.85.166.194]:38001 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1CrP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 May 2020 22:47:15 -0400
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966EC7122B2BFB9FEEDD74280B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: Anson Huang <anson.huang@nxp.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>

On Mon, May 18, 2020 at 05:58:42AM +0000, Aisheng Dong wrote:
> > From: Anson Huang <Anson.Huang@nxp.com>
> > Sent: Thursday, May 14, 2020 2:54 PM
> > 
> > Convert the imx pwm binding to DT schema format using json-schema.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt  | 27 ---------
> > Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 66
> > ++++++++++++++++++++++
> >  2 files changed, 66 insertions(+), 27 deletions(-)  delete mode 100644
> > Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > deleted file mode 100644
> > index 22f1c3d..0000000
> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > +++ /dev/null
> > @@ -1,27 +0,0 @@
> > -Freescale i.MX PWM controller
> > -
> > -Required properties:
> > -- compatible : should be "fsl,<soc>-pwm" and one of the following
> > -   compatible strings:
> > -  - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
> > -  - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
> > -- reg: physical base address and length of the controller's registers
> > -- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
> > -  in this directory for a description of the cells format.
> > -- clocks : Clock specifiers for both ipg and per clocks.
> > -- clock-names : Clock names should include both "ipg" and "per"
> > -See the clock consumer binding,
> > -	Documentation/devicetree/bindings/clock/clock-bindings.txt
> > -- interrupts: The interrupt for the pwm controller
> > -
> > -Example:
> > -
> > -pwm1: pwm@53fb4000 {
> > -	#pwm-cells = <3>;
> > -	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
> > -	reg = <0x53fb4000 0x4000>;
> > -	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
> > -		 <&clks IMX5_CLK_PWM1_HF_GATE>;
> > -	clock-names = "ipg", "per";
> > -	interrupts = <61>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > new file mode 100644
> > index 0000000..4b62af2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevice
> > +tree.org%2Fschemas%2Fpwm%2Fimx-pwm.yaml%23&amp;data=02%7C01%
> > 7Caisheng.d
> > +ong%40nxp.com%7C9b5cc1814a4b47d1cb0d08d7f7d4f594%7C686ea1d3bc
> > 2b4c6fa92c
> > +d99c5c301635%7C0%7C0%7C637250366331627865&amp;sdata=M2RPcty
> > wz61WZrpAW6S
> > +O3NJbr2wj2qXwnMMmBwCbInk%3D&amp;reserved=0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevice
> > +tree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Caishen
> > g.dong%
> > +40nxp.com%7C9b5cc1814a4b47d1cb0d08d7f7d4f594%7C686ea1d3bc2b4c
> > 6fa92cd99c
> > +5c301635%7C0%7C0%7C637250366331627865&amp;sdata=UxgYSClanyOjt
> > BmlyNrMZyF
> > +3%2F5awD%2FM3yaVPqgNKgxs%3D&amp;reserved=0
> > +
> > +title: Freescale i.MX PWM controller
> > +
> > +maintainers:
> > +  - Philipp Zabel <p.zabel@pengutronix.de>
> > +
> > +properties:
> > +  "#pwm-cells":
> > +    description: |
> > +      Should be 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
> > +      in this directory for a description of the cells format.
> 
> Should we add the reference to pwm.yaml?
> BTW, strange, I didn't see format description in pwm.yaml.

No need to. That's generally only needed when there's some structure 
like SPI or I2C bus to include.

Rob
