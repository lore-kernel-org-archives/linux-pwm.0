From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv10 0/4] Add Freescale FTM PWM support
Date: Wed, 19 Mar 2014 06:07:00 +0000
Message-ID: <14aa9d9e0e874ad4b3f26517e4042986@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1393493992-26073-1-git-send-email-Li.Xiubo@freescale.com>
 <20140318194457.GA5917@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1lp0142.outbound.protection.outlook.com ([207.46.163.142]:34509
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751941AbaCSGHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Mar 2014 02:07:05 -0400
In-Reply-To: <20140318194457.GA5917@mithrandir>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> Subject: Re: [PATCHv10 0/4] Add Freescale FTM PWM support
> 
> On Thu, Feb 27, 2014 at 05:39:48PM +0800, Xiubo Li wrote:
> > Changed in V10:
> >   Fix some bugs and adjust the code from Thierry's comments.
> >
> >
> > Xiubo Li (4):
> >   pwm: Add Freescale FTM PWM driver support
> >   ARM: dts: vf610: Add Freescale FTM PWM node.
> >   ARM: dts: vf610-twr: Enables FTM PWM device.
> >   Documentation: Add device tree bindings for Freescale FTM PWM.
> >
> >  .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |  35 ++
> >  arch/arm/boot/dts/vf610-twr.dts                    |   6 +
> >  arch/arm/boot/dts/vf610.dtsi                       |  13 +
> >  drivers/pwm/Kconfig                                |  10 +
> >  drivers/pwm/Makefile                               |   1 +
> >  drivers/pwm/pwm-fsl-ftm.c                          | 496
> +++++++++++++++++++++
> >  6 files changed, 561 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> >  create mode 100644 drivers/pwm/pwm-fsl-ftm.c
> 
> I've applied patches 1 and 4 to the PWM tree, with some minor cosmetic
> fixups that I thought didn't warrant these patches to go through yet
> another revision. =)
> 
> Thanks,
> Thierry

@Thierry,

Great, Thanks very much, 
:)


Best Regards,
Xiubo




