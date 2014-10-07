From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 14:28:41 +0100
Message-ID: <20141007132841.GE3693@lee--X1>
References: <20141007094727.GA12631@ulmo>
 <20141007095932.GY25331@lee--X1>
 <20141007100632.GA31575@ulmo>
 <20141007101743.GA25331@lee--X1>
 <20141007111304.GA1539@ulmo>
 <20141007113814.GA3693@lee--X1>
 <20141007134112.40179e8a@bbrezillon>
 <20141007115529.GA17434@ulmo>
 <20141007122224.GD3693@lee--X1>
 <5433E7A8.60001@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:52389 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbaJGN2s (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 09:28:48 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn15so4149580igb.9
        for <linux-pwm@vger.kernel.org>; Tue, 07 Oct 2014 06:28:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5433E7A8.60001@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

> >> That said, Nicolas Ferre (Cc'ing) at some point requested this to =
become
> >> a select (or at least for the DRM driver, but I guess the same app=
lies
> >> to PWM) on the grounds that a depends on will make it more difficu=
lt to
> >> enable the driver.
> >=20
> > It's not that much more difficult.  It just entails enabling 3 inst=
ead
> > of 2 config options.
>=20
> Yes it is more difficult. Believe me, it's a mess, but...
>=20
> > Once all of the required components are merged,
> > feel free to drop back to 'select'.  This is easier than sharing ro=
und
> > immutable branches all over the place.
>=20
> .. I agree with this option of moving to an easier-to-merge solution =
and
> then dealing with the ease of use.
>=20
> >> So we have two options here: 1) turn the select into a depends on =
here
> >> and allow the dependency to be resolved that way, or 2) solve the
> >> dependency by making sure the MFD part is merged first (either by
> >> pulling the MFD tree into the PWM and DRM trees or waiting for a f=
ull
> >> cycle for the MFD changes to land).
> >>
> >> I don't mind either way.
> >=20
> > I'll go with either of the two suggestions above.
>=20
> So, Lee and Thierry, you can both take your part in your respective
> trees with the change (1) described above and with my:
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Works for me.  The MFD part has already been applied.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
