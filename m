From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PWM...
Date: Sun, 19 Jan 2014 21:26:40 +0100
Message-ID: <201401192126.41543.arnd@arndb.de>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk> <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com> <20140119193026.GS15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63134 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaASU0v (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jan 2014 15:26:51 -0500
In-Reply-To: <20140119193026.GS15937@n2100.arm.linux.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "arm@kernel.org" <arm@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sunday 19 January 2014, Russell King - ARM Linux wrote:
> On Sun, Jan 19, 2014 at 11:11:41AM -0800, Olof Johansson wrote:
> > On Sun, Jan 19, 2014 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> > Ah, yes, if you add a cell that can be done. There'll still be the
> > "dead" first cell that will always be 0, but that's alright.
> 
> Does it not mean that PWM specifications of:
> 
>         <&pwm1 0 n> <&pwm2 0 n>
> 
> would need to be converted to:
> 
>         <&pwm1 0 n 0> <&pwm2 0 n 0>
> 
> in every DT file referring to these PWMs - because isn't this just
> treated in DT as one single array of values?  (If DT knew how many
> were in each specification, we wouldn't need the #foo-cells...)

Right: if you change an existing dts file from #pwm-cells=<2> to
#pwm-cells=<3>, that requires changing all references to the pwm
controller at the same time. If both the per-soc .dtsi files
and the per-board .dts files contain references to the same pwm
controller, that can end up in significant work. I have not checked
if this is the case for i.MX though.

	Arnd
