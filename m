From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: PWM...
Date: Sun, 19 Jan 2014 19:30:26 +0000
Message-ID: <20140119193026.GS15937@n2100.arm.linux.org.uk>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk> <20140119190324.GC28056@quad.lixom.net> <59642204.3UzJCDJHaS@wuerfel> <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41932 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751727AbaASTal (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jan 2014 14:30:41 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "arm@kernel.org" <arm@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sun, Jan 19, 2014 at 11:11:41AM -0800, Olof Johansson wrote:
> On Sun, Jan 19, 2014 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 19 January 2014 11:03:24 Olof Johansson wrote:
> >> >
> >> > Yes, because iMX6 specifies #pwm-cells as 2, there's no flags able to
> >> > be specified in the pwms declaration in pwmleds.  So that doesn't work.
> >> > There's no property to tell pwmleds that it should use inverted sense
> >> > either.
> >>
> >> Adding a property for active-low to the pwm-leds binding would be
> >> easy, and backwards compatible. I'm surprised the original binding
> >> didn't specify it. The leds-pwm driver already seems to support it for
> >> C-configured instances.
> >>
> >> I'm also surprised that the imx pwm driver even has a #pwm-cells of
> >> two, since the driver only supports one output. It'd be nice if they
> >> had allocated the extra cell for flags, but it's hard to change now,
> >> unless you do a new binding/compatible value and deprecate the old one.
> >
> > Actually I think it's not that hard to change: The binding can specify
> > that either #pwm-cells=<2> or #pwm-cells=<3> is supported, and the
> > driver extended to handle both cases. This would maintain backwards
> > compatibility for old dtb files, though no forward compatibility for
> > new dtb files with old kernels.
> 
> Ah, yes, if you add a cell that can be done. There'll still be the
> "dead" first cell that will always be 0, but that's alright.

Does it not mean that PWM specifications of:

	<&pwm1 0 n> <&pwm2 0 n>

would need to be converted to:

	<&pwm1 0 n 0> <&pwm2 0 n 0>

in every DT file referring to these PWMs - because isn't this just
treated in DT as one single array of values?  (If DT knew how many
were in each specification, we wouldn't need the #foo-cells...)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
