From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv9 Resend 4/4] Documentation: Add device tree bindings
 for Freescale FTM PWM.
Date: Thu, 27 Feb 2014 02:52:00 +0000
Message-ID: <ece53a62591545b7a22310694e2b15ed@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
 <1392799137-17188-5-git-send-email-Li.Xiubo@freescale.com>
 <20140226131355.GB29779@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:43307
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752607AbaB0CwD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 21:52:03 -0500
In-Reply-To: <20140226131355.GB29779@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> [...]
> > +- clocks : Must contain a clock specifier for each entry in clock-names,
> 
> Nit: A slightly more correct way to say this would be: "Must contain a
> phandle and clock specifier...".
> 

Yes, I will fix this.

Thanks very much,

--
Best Regards,
Xiubo

