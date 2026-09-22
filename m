Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F12EEE67
	for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2026 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036870; cv=pass; b=WBqwzUoygRCQRDp6yUXrosBJLs9W5B1fXPYRQEw86Iwn11PDY7xhl4jUEa3I7k1XYSvm1xcPLqPqi3c7ppDFQO3yoNwMCqNdiZFx0KlqbdlP7jm2MIRpfLtbofXVEIwrNJWavH8xBN5rkrC2tqLplzNIfJZcxKf6qkJzYAJ6dZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036870; c=relaxed/simple;
	bh=KZuQUl6j3h+Mz97kqvWqfN/U4j4CX1a7koVSy+p9AS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5W1wD6/2ewZxVTC8QT84UQ48fABU6n7F6a+8OOxGfDcsIYMd6X2xD/57dSwlkFttNYOpOEmBac/GZRXEeP7QCGVmqmBuUsiiBIurFuzlRzWbZn8ol+toIVevJuH56qYAoQYg3tHdnK3DdbkPZ8EN+bM3P1ryXyj4FX23tg2F7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnsZcXNI; arc=pass smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnsZcXNI"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97e96a8ba8cso2370230241.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 17:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790036865; cv=none;
        d=google.com; s=arc-20260327;
        b=PSPmhKP6+5Hf6xNRRC42HZjRG997TeazUiwfNAzEgC0sblI9xD06VqMWKH5gyCaXyk
         3KHb1TW35jOJWlppX6RkW85coK67JU2KluVRoahaF6TMk2PRcvRPZUdFnUFHUPMjQmxn
         U5wEj59ifEyQ4Lwq+Y/gzZ13xMbNMRcA53YCkMfXNgqc2zr+12JqRPAu9lmAK/VaU2Q4
         0NL+N4t5ulv6p8BANsD23VtJE8i5qc+CCjokoIqBj+MXDvygb0DwXVI/ORPHYwTDaZDl
         uVPmZDUROzaG3wAEnE54vItAblEOWTrGMHHcAfVgH4/Ozl70j2/9fw8Osvaeu5/U5ssZ
         AcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdNHV2Bp+pBoO9kVlK606by+2Um2lMvEyfFzfybbZS0=;
        fh=+iHAso9RWw0vceEvtwE6Sl6Ch9FKmgBCz1FJNYgS8J8=;
        b=g5IYuBFhEJG/v8GHQJjGMXInoHr73CRG7YbemKVutYqkNcHXXrdVhkNfD9Ku5FE134
         LcZM1SolE4g93SwW9Bv5gArZrPXDG32olY72X30hcoewlrAde1KA/HrqztEsGJdyKVcI
         +cn82s2ZC9n/8XwOFvZGSnnWDnMB1YjTZKcKff4E4bNjPxIW1Ry4iN6DIPlgZfvNY4+t
         qQeDFvEWPybMw7aujhG2uWh3cyTirxn/5fj3gMsMyD16obTn7x7O3hkgJU0KHAUiSaW4
         C715DfM8s14YDvRhTwLcefhqn0HSOoeimaUI/vyYeJ+NC0gSWBUdeU0RUbo45MWc+AG/
         UZRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790036865; x=1790641665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YdNHV2Bp+pBoO9kVlK606by+2Um2lMvEyfFzfybbZS0=;
        b=BnsZcXNIirsm/NvceyNa67Uy72+1/XVXDJ/Ae+A8GC16mA2QsVxegs7KCWwmLAdcIQ
         e+A1Fua55s+yEyf6PMQZdvxO0LD0HXyjGaCtZZbO3f13E+XnQG8w+LvxfEYh3oKXVzZi
         h0s+tTmmr5Fjn3QQAaPArYI+hoEulEpLH4OKRIPS5wpTSxe3DIJxzllZd7xlL9CqCD5s
         0NMf/aw9kx6inxeFJcyiIYhsXdyLbuoKDd3iRG6YfwsrNfHzGWfHV7FaPpsR2rcKSa4y
         dFhPV7ufbtMn8iGjWv1wakjDiya8YyARRne5vMQz8lcq8qL4J46vaQWsquBSOp7EFCQo
         55iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790036865; x=1790641665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdNHV2Bp+pBoO9kVlK606by+2Um2lMvEyfFzfybbZS0=;
        b=KNqKp9R8nstth80rtuG+eih0c9B1lTLlXrvyxuWyoGN3JA7QzBuZLFkOvmTGFhYZWf
         hYU3R8djUGXCarFZrMld/8sYaQhQ8qZ7Cc93dD0jmXmCOpYu8zVx9iXEm24/OC5wSo13
         z0QJiRboufONfsOF9pJdndMgvdSmEtQ/DxYUE7gMJOisNHxXqP+Eqe4qOomeJHBZ0Apo
         yQUo8L1bPvbeez0LWwWegNekaJknVZY8kxbj7N3JJqu6Aeh8231/G+CDieA2HpqS0SC7
         J97W3bwHz4avmK+DjMA599EaybgopnH5twekQnyT4hY23L9SuASG/qWQQ9+DYBqSsCsJ
         /pxg==
X-Forwarded-Encrypted: i=1; AKwUvBz7HKMZKTjDVDY2SggJHZt2tQp7rvAWF03dLRL0Wg0fz2mX1i7TpXAPBO++ouCGlpPt+DVx+ncKaAs=@vger.kernel.org
X-Gm-Message-State: AFuF++n0gXWpSX9QL/m7enawWrmlVjDzeLcFoJml4PFFiocK/bz+ARVL
	0vPuOaM/nyYYu4HqO29AzXhaO5MkekgP8Pgxlxdj5TCalNe/6R/8hu75GWhDfOFYwPwWP6Ip8CM
	OuaA1fG5Thjbhf2qrgBPauJ2I+gBBjck=
X-Gm-Gg: AYBFou24ePGuwh55apR5XGySwmdCqJk+9LuZSni37MPTl7b8aXRzjox+ou5rv69KVhu
	yKjqA/eHFFZ129ATV+hBdjY+S6G4x0k6YznqkKvyLfkzhwHLxpSie50xS0Fcr9fK2/Psmy7m+1z
	oTeo4jZ9xGY0WxpTNIU4OmL8JqdOaY44GHNKag1ELfFTBmtrHeSYcrBwtTuDCgU+8D3vKMHhln9
	/Ia8QH/+ufXhVuhG3z3cElg6i5SKmLyu10nNP8Ei2n1LgNPC+xpaOWJnxOeDRuWQHBP7rv33tod
	Ts5GbxvJHZLrtWJMlJkz4xeCwPYS67LnaPpVq1k5PhQm3XUBoBA3eOIr1vUQJE8AUZGaLxcZN2Q
	ZEr3Yw4WfD1iQvhMBklJjo9rrSCvUv0PDABjbHo+bCqN4TGFByvDt/hTYxsDO7NtY210RZerTp3
	+GyDPUJYQecl1udSGVIWyQJO0LDb4RdTMS9zhNKtySwLC07g==
X-Received: by 2002:a05:6102:41ac:b0:7a4:e550:eeb9 with SMTP id
 ada2fe7eead31-7a55d28bba5mr6355109137.22.1790036864147; Mon, 21 Sep 2026
 17:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
 <20260804-h616-pwm-v8-v8-2-db37ab8624ae@gmail.com> <arFMta6PPwmzSk86@monoceros>
In-Reply-To: <arFMta6PPwmzSk86@monoceros>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 21 Sep 2026 18:27:32 -0600
X-Gm-Features: AcwNN1Vgt9tQWH-VXMx3Ce7Bhal86EY0c60lldp0ESwVW29QW4CscmXbfzfDy48
Message-ID: <CADvTj4r1sFjPko7G5DwrPUw9x1tPzQspJhCUmHSMtrudn7SXEQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] pwm: sun8i: Add H616 PWM support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> On Tue, Aug 04, 2026 at 03:27:25PM -0600, James Hilliard wrote:
> > From: Richard Genoud <richard.genoud@bootlin.com>
> >
> > Add a driver for the Allwinner H616 PWM controller, supporting six
> > channels. Each channel output can carry either a PWM waveform or a cloc=
k
> > from its bypass path.
> >
> > The channels are paired as 0/1, 2/3 and 4/5. Each pair shares a mux, ga=
te
> > and prescaler, while each channel has its own prescaler and bypass.
> >
> > Register each shared pair mux, divider and gate with the Common Clock
> > Framework, and expose each channel bypass as a clock output. Program th=
e
> > channel-specific divider directly in the PWM path. Arbitrate each outpu=
t
> > when the PWM is requested or the bypass clock is prepared, and hold the
> > shared pair rate exclusively while either sibling output is active.
> >
> > CCF reference counts do not describe outputs left active by firmware.
> > Before disabling a pair gate or changing its rate, also inspect the
> > hardware channel-enable bits. Preserve inherited outputs through generi=
c
> > unused-clock cleanup so declared consumers can claim them. At driver
> > sync_state(), stop channels which remain unowned and reconcile an empty
> > shared pair gate through CCF. This prevents both premature shutdown of =
a
> > late-probing consumer and indefinite unclaimed outputs.
> >
> > The clock-provider interface is needed because pwm-clock cannot accurat=
ely
> > represent the bypass path. For example, pwm-clock represents 24 MHz as =
an
> > integer 42 ns PWM period. The PWM waveform-rounding rules happen to sel=
ect
> > the H616 bypass and produce 24 MHz for that request, but the pwm-clock =
API
> > does not require its advertised clock rate to equal the rounded hardwar=
e
> > waveform.
>
> I don't understand the issue here. When you write pwm-clock, do you mean
> drivers/clk/clk-pwm.c or drivers/pwm/pwm-clk.c? (I guess the former.)

Yes, drivers/clk/clk-pwm.c. You're right that the 42 ns period, 21 ns duty
request selects the 24 MHz bypass when that rate is available.

> If you do
>
>         compatible =3D "pwm-clock";
>         clock-frequency =3D <24000000>;
>         pwms =3D <&pwm0 42 ...>;
>
> that should give you a reliable match?!
>
> > Exposing the bypass through CCF provides an exact rate request,
> > conveys that duty-cycle and polarity control are not needed, and makes =
the
> > shared pair clock visible to CCF rate arbitration.
>
> Are you "just" suffering that clocks are programmed in Hz which PWMs are
> programmed in ns and thus your losing precision on divisions?

There is also the distinction between the advertised and resulting rate.
clk-pwm advertises its configured fixed frequency without checking the
rounded PWM frequency. If an active sibling holds the shared pair at
100 MHz, that same request rounds to 40 ns with 20 ns high time, i.e.
25 MHz, while pwm-clock still reports 24 MHz.

The direct provider reports the actual pair rate and exposes its shared
rate protection to CCF. CCF can still round a rate request, so this is not
an unconditional exact-rate guarantee. I've clarified that in v9.

> > Wait for the hardware period-update handshake before replacing PPR. Tra=
ck
> > the active and newly programmed periods so normal updates use a tight
> > timeout, while an unknown firmware update conservatively allows the max=
imum
> > hardware period. Scale the sleep interval to keep the number of MMIO po=
lls
> > bounded even for very long periods.
> >
> > Dead-zone mode is not representable by the PWM API. Reject it while eit=
her
> > output in the pair is active, but clear dormant dead-zone enable state =
when
> > both outputs are disabled so stale firmware configuration does not
> > permanently prevent ordinary PWM use.
> >
> > Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> > Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v7 -> v8:
> >   - clear the complete two-bit clock-source selector field
> >   - leave rate and period registers untouched when disabling a channel
> >   - distinguish PWM-owned bypass signals from clock-owned bypass output=
s
> >   - round waveforms over all parent, pair-divider, channel-divider and =
bypass
> >     choices according to the PWM core ordering
> >   - encode constant levels without overflowing the 16-bit active-cycle =
field
> >   - allocate clock topology state per device and use the fixed parent m=
ap
> >     (reported by Sashiko)
> >   - use managed clock registrations for complete probe-error cleanup
> >     (reported by Sashiko and suggested by Philipp)
> >   - deassert reset before registering clocks and keep the reset handle =
local
> >     (reported by Sashiko and suggested by Philipp)
> >   - arbitrate channel ownership in clock prepare/unprepare and select b=
ypass
> >     only while the clock output is enabled  (reported by Sashiko)
> >   - roll back failed PWM requests and serialize channel release
> >     (reported by Sashiko)
> >   - protect the shared pair source while either sibling channel is acti=
ve
> >     (reported by Sashiko)
> >   - preserve the 65536-tick duty intermediate before polarity conversio=
n
> >     (reported by Sashiko)
> >   - avoid replaying write-one control bits while changing channel setti=
ngs
> >     (reported by Sashiko)
> >   - keep the hardware-waveform state within the PWM core storage limit
> >   - clarify that either co-packaged AC200 or AC300 PHY uses the bypass =
clock
> >   - drop Tested-by tags after the clock implementation was reworked
> >   - quantize inverted waveforms in hardware ticks and report their
> >     physical offset
> >   - force released channels off so stale waveforms cannot restart with =
a
> >     sibling
> >   - track the active and pending cycle for the period-update handshake =
and
> >     adapt the sleep interval to bound MMIO polling on long periods
> >   - quiesce rate, polarity and bypass transitions before reprogramming =
the
> >     output
> >   - clear unsupported pulse mode when programming periodic waveforms
> >   - preserve firmware-active outputs through generic unused-clock clean=
up,
> >     stop any still-unclaimed channels at sync_state(), reconcile empty =
pair
> >     gates through CCF, and reject pair retuning while either output is
> >     active
> >   - hold pair-rate exclusivity only while an output is active
> >   - make pair-rate changes transactional and restore a quiesced output =
on
> >     failure
> >   - clear dormant dead-zone state when both pair outputs are disabled,
> >     while rejecting active dead-zone and pulse modes which the PWM API
> >     cannot represent
> >   - correct the hardware topology to show the pair gate before div_m
> >   - remove unused register definitions and simplify the fixed parent
> >     topology
> > ---
> >  drivers/pwm/Kconfig     |   12 +
> >  drivers/pwm/Makefile    |    1 +
> >  drivers/pwm/pwm-sun8i.c | 1542 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 1555 insertions(+)
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index e8886a9b64d9..e7fd2e66b1aa 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -748,6 +748,18 @@ config PWM_SUN4I
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-sun4i.
> >
> > +config PWM_SUN8I
> > +     tristate "Allwinner sun8i/sun50i PWM support"
> > +     depends on ARCH_SUNXI || COMPILE_TEST
> > +     depends on HAS_IOMEM && COMMON_CLK
> > +     help
> > +       PWM framework driver for Allwinner controllers whose channels s=
hare
> > +       paired source clocks. In addition to PWM operation, each channe=
l's
> > +       hardware bypass path can be exported as a clock output.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sun8i.
> > +
> >  config PWM_SUNPLUS
> >       tristate "Sunplus PWM support"
> >       depends on ARCH_SUNPLUS || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 5630a521a7cf..9c922b1fd0b4 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -68,6 +68,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > +obj-$(CONFIG_PWM_SUN8I)              +=3D pwm-sun8i.o
> >  obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >  obj-$(CONFIG_PWM_TH1520)     +=3D pwm_th1520.o
> > diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> > new file mode 100644
> > index 000000000000..5c3580a0924d
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sun8i.c
> > @@ -0,0 +1,1542 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Driver for Allwinner sun8i Pulse Width Modulation Controller
> > + *
> > + * (C) Copyright 2025 Richard Genoud, Bootlin <richard.genoud@bootlin.=
com>
> > + * (C) Copyright 2026 James Hilliard <james.hilliard1@gmail.com>
> > + *
> > + * Based on drivers/pwm/pwm-sun4i.c with Copyright:
> > + *
> > + * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@bootlin.com=
>
> > + *
> > + * Channels are paired (0/1, 2/3, 4/5). Each pair shares a clock sourc=
e and
> > + * first prescaler (div_m), while each channel has its own second pres=
caler
> > + * (div_k) and bypass path.
> > + *
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/limits.h>
> > +#include <linux/math64.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/time.h>
> > +
> > +/* PWMCC Pairs Clock Configuration Registers */
> > +#define SUN8I_PWM_PCCR(pair)         (0x20 + ((pair) * 0x4))
> > +#define SUN8I_PWM_PCCR_SRC_SHIFT     7
> > +#define SUN8I_PWM_PCCR_SRC_MASK              GENMASK(1, 0)
> > +#define SUN8I_PWM_PCCR_GATE_BIT              4
> > +#define SUN8I_PWM_PCCR_GATE          BIT(SUN8I_PWM_PCCR_GATE_BIT)
> > +#define SUN8I_PWM_PCCR_BYPASS_BIT(chan)      ((chan) % 2 + 5)
> > +#define SUN8I_PWM_PCCR_DIV_M_SHIFT   0
> > +#define SUN8I_PWM_PCCR_DIV_M_WIDTH   4
> > +
> > +/* PWM Enable Register */
> > +#define SUN8I_PWM_PER                        0x40
> > +#define SUN8I_PWM_ENABLE(chan)               BIT(chan)
> > +
> > +/* PWM Control Register */
> > +#define SUN8I_PWM_PCR(chan)          (0x60 + (chan) * 0x20)
> > +#define SUN8I_PWM_PCR_PRESCAL_K_MASK GENMASK(7, 0)
> > +#define SUN8I_PWM_PCR_ACTIVE_STATE   BIT(8)
> > +#define SUN8I_PWM_PCR_MODE           BIT(9)
> > +#define SUN8I_PWM_PCR_PULSE_START    BIT(10)
> > +#define SUN8I_PWM_PCR_PERIOD_READY   BIT(11) /* 0: ready, 1: busy */
> > +
> > +/* PWM Period Register */
> > +#define SUN8I_PWM_PPR(chan)          (0x64 + (chan) * 0x20)
> > +#define SUN8I_PWM_PPR_PERIOD_MASK    GENMASK(31, 16)
> > +#define SUN8I_PWM_PPR_DUTY_MASK              GENMASK(15, 0)
> > +#define SUN8I_PWM_PPR_PERIOD_VALUE(reg)      (FIELD_GET(SUN8I_PWM_PPR_=
PERIOD_MASK, reg) + 1)
> > +#define SUN8I_PWM_PPR_DUTY_VALUE(reg)        FIELD_GET(SUN8I_PWM_PPR_D=
UTY_MASK, reg)
> > +#define SUN8I_PWM_PPR_PERIOD(prd)    FIELD_PREP(SUN8I_PWM_PPR_PERIOD_M=
ASK, (prd) - 1)
> > +#define SUN8I_PWM_PPR_DUTY(dty)              FIELD_PREP(SUN8I_PWM_PPR_=
DUTY_MASK, dty)
> > +#define SUN8I_PWM_PPR_PERIOD_MAX     (FIELD_MAX(SUN8I_PWM_PPR_PERIOD_M=
ASK) + 1)
> > +
> > +/* PWM pair dead-zone control registers. */
> > +#define SUN8I_PWM_PDZCR(pair)                (0x30 + ((pair) * 0x4))
> > +#define SUN8I_PWM_PDZCR_ENABLE               BIT(0)
> > +
> > +#define SUN8I_PWM_PERIOD_READY_MARGIN_US     50
> > +#define SUN8I_PWM_PERIOD_READY_MIN_POLL_US   10
> > +#define SUN8I_PWM_PERIOD_READY_MAX_POLL_US   10000
> > +#define SUN8I_PWM_PERIOD_READY_POLL_COUNT    1024
> > +
> > +#define SUN8I_PWM_PAIR_IDX(chan)     ((chan) >> 1)
> > +
> > +/*
> > + * Block diagram of the PWM clock controller:
> > + *
> > + *             _____      ______      ________
> > + * OSC24M --->|     |    |      |    |        |
> > + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> SUN8I_PWM_clock_=
src_xy
> > + *            |_____|    |______|    |________|
> > + *                               ________
> > + *                              |        |
> > + *                           +->| /div_k |---> SUN8I_PWM_clock_x
> > + *                           |  |________|
> > + *                           |    ______
> > + *                           |   |      |
> > + *                           +-->| Gate |----> SUN8I_PWM_bypass_clock_=
x
> > + *                           |   |______|
> > + * SUN8I_PWM_clock_src_xy ---+   ________
> > + *                           |  |        |
> > + *                           +->| /div_k |---> SUN8I_PWM_clock_y
> > + *                           |  |________|
> > + *                           |    ______
> > + *                           |   |      |
> > + *                           +-->| Gate |----> SUN8I_PWM_bypass_clock_=
y
> > + *                               |______|
> > + *
> > + * NB: when the bypass is set, all the PWM logic is bypassed.
> > + * So, the duty cycle and polarity can't be modified (we just have a c=
lock).
> > + * The bypass in PWM mode is used to achieve a 1/2 relative duty cycle=
 with the
> > + * fastest clock.
> > + *
> > + * SUN8I_PWM_clock_x/y serve for the PWM purpose.
> > + * SUN8I_PWM_bypass_clock_x/y serve for the clock-provider purpose.
> > + *
> > + */
> > +
> > +/* /div_m is a power-of-two divider limited to /256. */
> > +static const struct clk_div_table sun8i_pwm_div_m_table[] =3D {
> > +     { .val =3D 0, .div =3D 1 },
> > +     { .val =3D 1, .div =3D 2 },
> > +     { .val =3D 2, .div =3D 4 },
> > +     { .val =3D 3, .div =3D 8 },
> > +     { .val =3D 4, .div =3D 16 },
> > +     { .val =3D 5, .div =3D 32 },
> > +     { .val =3D 6, .div =3D 64 },
> > +     { .val =3D 7, .div =3D 128 },
> > +     { .val =3D 8, .div =3D 256 },
> > +     { /* sentinel */ }
> > +};
> > +
> > +enum sun8i_pwm_mode {
> > +     SUN8I_PWM_MODE_NONE,
> > +     SUN8I_PWM_MODE_PWM,
> > +     SUN8I_PWM_MODE_CLK,
> > +};
> > +
> > +struct sun8i_pwm_data {
> > +     unsigned int npwm;
> > +};
> > +
> > +struct sun8i_pwm_chip;
> > +
> > +struct sun8i_pwm_pair {
> > +     struct clk_mux mux;
> > +     struct clk_hw gate_hw;
> > +     struct clk_divider divider;
> > +     struct clk_hw *hw;
> > +     struct notifier_block rate_nb;
> > +     struct sun8i_pwm_chip *chip;
> > +     unsigned int index;
> > +};
> > +
> > +struct sun8i_pwm_bypass {
> > +     struct clk_hw hw;
> > +     struct sun8i_pwm_chip *chip;
> > +     unsigned int index;
> > +};
> > +
> > +struct sun8i_pwm_channel {
> > +     struct sun8i_pwm_bypass bypass;
> > +     struct clk *pair_clk;
> > +     enum sun8i_pwm_mode mode;
> > +     u64 pending_period_ns;
> > +     bool rate_exclusive;
> > +};
> > +
> > +struct sun8i_pwm_chip {
> > +     struct clk_hw_onecell_data *hw_data;
> > +     struct sun8i_pwm_pair *pairs;
> > +     struct sun8i_pwm_channel *channels;
> > +     struct clk *bus_clk;
> > +     void __iomem *base;
> > +     const struct sun8i_pwm_data *data;
> > +     /* Protects shared registers and channel ownership. */
> > +     spinlock_t lock;
> > +};
> > +
> > +struct sun8i_pwm_waveform {
> > +     u32 duty_ticks;
> > +     u32 period_ticks;
> > +     u32 pair_rate;
> > +     u16 div_k;
> > +     u8 enabled:1;
> > +     u8 active_state:1;
> > +     u8 bypass_en:1;
> > +};
> > +
> > +static inline struct sun8i_pwm_chip *sun8i_pwm_from_chip(const struct =
pwm_chip *chip)
> > +{
> > +     return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *sun8i_chip,
> > +                               unsigned long offset)
> > +{
> > +     return readl(sun8i_chip->base + offset);
> > +}
> > +
> > +static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *sun8i_chip,
> > +                                 u32 val, unsigned long offset)
> > +{
> > +     writel(val, sun8i_chip->base + offset);
> > +}
> > +
> > +static void sun8i_pwm_set_bypass_locked(struct sun8i_pwm_chip *sun8i_c=
hip,
> > +                                     unsigned int idx, bool enable)
> > +{
> > +     unsigned long reg_offset;
> > +     u32 val;
> > +
> > +     lockdep_assert_held(&sun8i_chip->lock);
> > +
> > +     reg_offset =3D SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(idx));
> > +     val =3D sun8i_pwm_readl(sun8i_chip, reg_offset);
> > +     if (enable)
> > +             val |=3D BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> > +     else
> > +             val &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> > +
> > +     sun8i_pwm_writel(sun8i_chip, val, reg_offset);
> > +}
> > +
> > +static void sun8i_pwm_set_enabled_locked(struct sun8i_pwm_chip *sun8i_=
chip,
> > +                                      unsigned int idx, bool enable)
> > +{
> > +     u32 val;
> > +
> > +     lockdep_assert_held(&sun8i_chip->lock);
> > +
> > +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     if (enable)
> > +             val |=3D SUN8I_PWM_ENABLE(idx);
> > +     else
> > +             val &=3D ~SUN8I_PWM_ENABLE(idx);
> > +     sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PER);
> > +}
> > +
> > +static bool
> > +sun8i_pwm_channel_is_enabled_locked(struct sun8i_pwm_chip *sun8i_chip,
> > +                                 unsigned int idx)
> > +{
> > +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(idx);
> > +     u32 pccr, per;
> > +
> > +     lockdep_assert_held(&sun8i_chip->lock);
> > +
> > +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> > +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +
> > +     return (pccr & SUN8I_PWM_PCCR_GATE) &&
> > +            (per & SUN8I_PWM_ENABLE(idx));
> > +}
> > +
> > +static u32 sun8i_pwm_pair_enable_mask(struct sun8i_pwm_chip *sun8i_chi=
p,
> > +                                   unsigned int pair)
> > +{
> > +     unsigned int first =3D pair * 2;
> > +     u32 mask =3D SUN8I_PWM_ENABLE(first);
> > +
> > +     if (first + 1 < sun8i_chip->data->npwm)
> > +             mask |=3D SUN8I_PWM_ENABLE(first + 1);
> > +
> > +     return mask;
> > +}
> > +
> > +static u32
> > +sun8i_pwm_pair_owner_mask_locked(struct sun8i_pwm_chip *sun8i_chip,
> > +                              unsigned int pair)
> > +{
> > +     unsigned int first =3D pair * 2;
> > +     u32 mask =3D 0;
> > +
> > +     lockdep_assert_held(&sun8i_chip->lock);
> > +
> > +     if (sun8i_chip->channels[first].mode !=3D SUN8I_PWM_MODE_NONE)
> > +             mask |=3D SUN8I_PWM_ENABLE(first);
> > +     if (first + 1 < sun8i_chip->data->npwm &&
> > +         sun8i_chip->channels[first + 1].mode !=3D SUN8I_PWM_MODE_NONE=
)
> > +             mask |=3D SUN8I_PWM_ENABLE(first + 1);
> > +
> > +     return mask;
> > +}
> > +
> > +static inline struct sun8i_pwm_pair *
> > +sun8i_pwm_pair_from_gate_hw(struct clk_hw *hw)
> > +{
> > +     return container_of(hw, struct sun8i_pwm_pair, gate_hw);
> > +}
> > +
> > +static int sun8i_pwm_pair_gate_enable(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> > +     unsigned long flags;
> > +     u32 pccr;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair->index))=
;
> > +     pccr |=3D SUN8I_PWM_PCCR_GATE;
> > +     sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pair->index));
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sun8i_pwm_pair_gate_disable(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> > +     unsigned long reg =3D SUN8I_PWM_PCCR(pair->index);
> > +     unsigned long flags;
> > +     u32 pccr, per;
> > +
> > +     /* CCF counts do not include outputs awaiting firmware-state hand=
off. */
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     if (!(per & sun8i_pwm_pair_enable_mask(sun8i_chip, pair->index)))=
 {
> > +             pccr =3D sun8i_pwm_readl(sun8i_chip, reg);
> > +             pccr &=3D ~SUN8I_PWM_PCCR_GATE;
> > +             sun8i_pwm_writel(sun8i_chip, pccr, reg);
> > +     }
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +}
> > +
> > +static int sun8i_pwm_pair_gate_is_enabled(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> > +     unsigned long reg =3D SUN8I_PWM_PCCR(pair->index);
> > +     unsigned long flags;
> > +     bool enabled;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     enabled =3D sun8i_pwm_readl(sun8i_chip, reg) & SUN8I_PWM_PCCR_GAT=
E;
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return enabled;
> > +}
> > +
> > +static const struct clk_ops sun8i_pwm_pair_gate_ops =3D {
> > +     .enable =3D sun8i_pwm_pair_gate_enable,
> > +     .disable =3D sun8i_pwm_pair_gate_disable,
> > +     .is_enabled =3D sun8i_pwm_pair_gate_is_enabled,
> > +};
> > +
> > +static int sun8i_pwm_pair_rate_notifier(struct notifier_block *nb,
> > +                                     unsigned long event, void *data)
> > +{
> > +     struct sun8i_pwm_pair *pair =3D
> > +             container_of(nb, struct sun8i_pwm_pair, rate_nb);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> > +     unsigned long flags;
> > +     bool active;
> > +
> > +     if (event !=3D PRE_RATE_CHANGE)
> > +             return NOTIFY_DONE;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     active =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER) &
> > +              sun8i_pwm_pair_enable_mask(sun8i_chip, pair->index);
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return active ? NOTIFY_BAD : NOTIFY_OK;
> > +}
> > +
> > +static inline struct sun8i_pwm_bypass *
> > +sun8i_pwm_bypass_from_hw(struct clk_hw *hw)
> > +{
> > +     return container_of(hw, struct sun8i_pwm_bypass, hw);
> > +}
> > +
> > +static int sun8i_pwm_bypass_prepare(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypass->=
index];
> > +     unsigned long flags;
> > +     int ret =3D 0;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     if (chan->mode !=3D SUN8I_PWM_MODE_NONE)
> > +             ret =3D -EBUSY;
> > +     else
> > +             chan->mode =3D SUN8I_PWM_MODE_CLK;
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static void sun8i_pwm_bypass_unprepare(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypass->=
index];
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK))
> > +             goto out_unlock;
> > +
> > +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> > +
> > +out_unlock:
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +}
> > +
> > +static int sun8i_pwm_bypass_enable(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypass->=
index];
> > +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(bypass->index);
> > +     unsigned long flags;
> > +     u32 pccr, per;
> > +     int ret =3D 0;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK)) {
> > +             ret =3D -EBUSY;
> > +             goto out_unlock;
> > +     }
> > +
> > +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> > +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     if (!(pccr & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(bypass->index))) ||
> > +         !(per & SUN8I_PWM_ENABLE(bypass->index))) {
> > +             sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->index, f=
alse);
> > +             sun8i_pwm_set_bypass_locked(sun8i_chip, bypass->index, tr=
ue);
> > +             sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->index, t=
rue);
> > +     }
> > +
> > +out_unlock:
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static void sun8i_pwm_bypass_disable(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypass->=
index];
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK))
> > +             goto out_unlock;
> > +
> > +     sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->index, false);
> > +     sun8i_pwm_set_bypass_locked(sun8i_chip, bypass->index, false);
> > +
> > +out_unlock:
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +}
> > +
> > +static void sun8i_pwm_bypass_disable_unused(struct clk_hw *hw)
> > +{
> > +     /* Defer inherited-output cleanup to sun8i_pwm_sync_state(). */
> > +}
>
> I would expect that you can drop this empty callback?!

Removed in v9, with CLK_IGNORE_UNUSED replacing it. Simply removing the
callback would make CCF fall back to .disable(). The flag expresses the
intent to preserve unclaimed firmware outputs through unused-clock
cleanup; normal consumer disable still turns the output off.

>
> > +static int sun8i_pwm_bypass_is_enabled(struct clk_hw *hw)
> > +{
> > +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(hw);
> > +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> > +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(bypass->index);
> > +     unsigned long flags;
> > +     bool enabled;
> > +     u32 val;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +
> > +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> > +     enabled =3D (val & SUN8I_PWM_PCCR_GATE) &&
> > +               (val & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(bypass->index)));
> > +
> > +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     enabled =3D enabled && (val & SUN8I_PWM_ENABLE(bypass->index));
> > +
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return enabled;
> > +}
> > +
> > +static unsigned long sun8i_pwm_bypass_recalc_rate(struct clk_hw *hw,
> > +                                               unsigned long parent_ra=
te)
> > +{
> > +     return parent_rate;
> > +}
> > +
> > +static const struct clk_ops sun8i_pwm_bypass_ops =3D {
> > +     .prepare =3D sun8i_pwm_bypass_prepare,
> > +     .unprepare =3D sun8i_pwm_bypass_unprepare,
> > +     .enable =3D sun8i_pwm_bypass_enable,
> > +     .disable =3D sun8i_pwm_bypass_disable,
> > +     .disable_unused =3D sun8i_pwm_bypass_disable_unused,
> > +     .is_enabled =3D sun8i_pwm_bypass_is_enabled,
> > +     .recalc_rate =3D sun8i_pwm_bypass_recalc_rate,
> > +};
>
> I have problems grokking how the clk and pwm frameworks interact here. I
> think that would be easier to understand if you split this patch into
> a basic pwm driver and in a 2nd patch add the clk stuff. Maybe also
> split out the bypass stuff?

V9 separates PWM support in patch 2 from the exported bypass clocks and
PWM/clock ownership arbitration in patch 3.

PWM request/free and clock prepare/unprepare arbitrate ownership of the
physical output, so the two interfaces cannot own it simultaneously.

The internal CCF pair clocks remain in patch 2, so both patches use the
same implementation of the shared mux, divider and gate. Hardware bypass
rounding also stays there: it is part of PWM waveform generation and
inherited-state readback, independently of exporting a clock provider

> > +static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> > +{
> > +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwp=
wm];
> > +     unsigned int idx =3D pwm->hwpwm;
> > +     unsigned long flags;
> > +     bool was_enabled =3D false;
> > +     int ret;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     if (chan->mode !=3D SUN8I_PWM_MODE_NONE) {
> > +             ret =3D -EBUSY;
> > +     } else {
> > +             was_enabled =3D
> > +                     sun8i_pwm_channel_is_enabled_locked(sun8i_chip, i=
dx);
> > +             chan->mode =3D SUN8I_PWM_MODE_PWM;
> > +             ret =3D 0;
> > +     }
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +     if (ret)
> > +             return ret;
>
> With scoped_guard() this can be written in a nicer way.

Converted to guard()/scoped_guard() in v9.

> > +     if (was_enabled) {
> > +             ret =3D clk_rate_exclusive_get(chan->pair_clk);
> > +             if (ret)
> > +                     goto err_release_channel;
> > +             WRITE_ONCE(chan->rate_exclusive, true);
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(chan->pair_clk);
> > +     if (ret) {
> > +             if (READ_ONCE(chan->rate_exclusive)) {
> > +                     clk_rate_exclusive_put(chan->pair_clk);
> > +                     WRITE_ONCE(chan->rate_exclusive, false);
> > +             }
> > +             goto err_release_channel;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_release_channel:
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> > +{
> > +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwp=
wm];
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_PWM)) {
>
> WARN_ON is usually frowned upon, see e.g.
> https://lore.kernel.org/all/2026091953-cherub-empty-ef35@gregkh/.

Removed the ownership WARN_ON_ONCE() calls.

> > +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +             return;
> > +     }
> > +
> > +     sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, false);
> > +     sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false);
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     if (READ_ONCE(chan->rate_exclusive)) {
>
> given this isn't performance critical (is it?) and we have a lock
> anyhow, I'd prefer to have chan->rate_exclusive protected by that lock,
> too, instead of mixing different atomics here.

All accesses to rate_exclusive now use the shared register/ownership
lock. The CCF operations stay outside that spinlock because they take the
prepare mutex and can call back into the driver.

> > +             clk_rate_exclusive_put(chan->pair_clk);
> > +             WRITE_ONCE(chan->rate_exclusive, false);
> > +     }
> > +     clk_disable_unprepare(chan->pair_clk);
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +}
> > +
> > +static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
> > +                                struct pwm_device *pwm,
> > +                                void *_wfhw)
> > +{
> > +     struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> > +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwp=
wm];
> > +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(pwm->hwpwm);
> > +     unsigned long flags, pair_rate;
> > +     u32 pccr, pcr, pdzcr, per, ppr;
> > +
> > +     pair_rate =3D clk_get_rate(chan->pair_clk);
> > +     if (pair_rate > U32_MAX)
> > +             return -ERANGE;
>
> That should not happen. You lock the rate in .request(). So please check
> the rate already there and return an error code.

The rate is only protected while the PWM is active, not for its entire
requested lifetime. A requested but disabled PWM must still allow its
sibling to change the pair rate. Also, debugfs reads hardware state for
channels which have not been requested.

I therefore kept the checks where the rate is used rather than moving
them solely to .request().

> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> > +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm));
> > +     ppr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm));
> > +     pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     *wfhw =3D (struct sun8i_pwm_waveform) {
> > +             .enabled =3D !!(pccr & SUN8I_PWM_PCCR_GATE) &&
> > +                        !!(per & SUN8I_PWM_ENABLE(pwm->hwpwm)),
> > +             .bypass_en =3D !!(pccr &
> > +                              BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pwm->hwpwm=
))),
> > +             .active_state =3D !!(pcr & SUN8I_PWM_PCR_ACTIVE_STATE),
> > +             .duty_ticks =3D SUN8I_PWM_PPR_DUTY_VALUE(ppr),
> > +             .period_ticks =3D SUN8I_PWM_PPR_PERIOD_VALUE(ppr),
> > +             .pair_rate =3D pair_rate,
> > +             .div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pcr) +=
 1,
> > +     };
> > +
> > +     if (wfhw->enabled && !wfhw->bypass_en &&
> > +         (pdzcr & SUN8I_PWM_PDZCR_ENABLE))
> > +             return -EOPNOTSUPP;
> > +     if (wfhw->enabled && !wfhw->bypass_en &&
> > +         (pcr & SUN8I_PWM_PCR_MODE))
> > +             return -EOPNOTSUPP;
>
> These need at least a comment.

Added a comment explaining that the waveform API cannot represent pulse
mode or coupled dead-zone operation, and combined the rejection checks.

> > +     return 0;
> > +}
> > +
> > +static u64 sun8i_pwm_ticks_to_ns(u32 ticks, u16 div_k, u32 pair_rate)
> > +{
> > +     return DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)ticks * div_k,
> > +                             pair_rate);
> > +}
> > +
> > +static void
> > +sun8i_pwm_waveform_to_ns(const struct sun8i_pwm_waveform *wfhw,
> > +                      struct pwm_waveform *wf)
> > +{
> > +     u32 pair_rate =3D wfhw->pair_rate;
> > +     u16 div_k =3D wfhw->div_k;
> > +
> > +     wf->duty_offset_ns =3D 0;
> > +
> > +     if (!wfhw->enabled || !pair_rate) {
> > +             wf->period_length_ns =3D 0;
> > +             wf->duty_length_ns =3D 0;
> > +             return;
> > +     }
> > +
> > +     if (wfhw->bypass_en) {
> > +             wf->period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> > +                                                     pair_rate);
> > +             wf->duty_length_ns =3D
> > +                     DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> > +                                      2ULL * pair_rate);
> > +     } else {
> > +             wf->period_length_ns =3D sun8i_pwm_ticks_to_ns(wfhw->peri=
od_ticks,
> > +                                                          div_k, pair_=
rate);
> > +             if (wfhw->active_state) {
> > +                     u32 duty_ticks =3D min(wfhw->duty_ticks,
> > +                                          wfhw->period_ticks);
> > +
> > +                     wf->duty_length_ns =3D
> > +                             sun8i_pwm_ticks_to_ns(duty_ticks, div_k, =
pair_rate);
> > +             } else if (!wfhw->duty_ticks) {
> > +                     wf->duty_length_ns =3D wf->period_length_ns;
> > +             } else if (wfhw->duty_ticks >=3D wfhw->period_ticks) {
> > +                     wf->duty_length_ns =3D 0;
> > +             } else {
> > +                     u32 low_ticks =3D wfhw->duty_ticks;
> > +                     u32 high_ticks =3D wfhw->period_ticks - wfhw->dut=
y_ticks;
> > +
> > +                     wf->duty_length_ns =3D
> > +                             sun8i_pwm_ticks_to_ns(high_ticks, div_k, =
pair_rate);
> > +                     wf->duty_offset_ns =3D
> > +                             sun8i_pwm_ticks_to_ns(low_ticks, div_k, p=
air_rate);
> > +             }
> > +     }
> > +}
> > +
> > +static int sun8i_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> > +                                        struct pwm_device *pwm,
> > +                                        const void *_wfhw,
> > +                                        struct pwm_waveform *wf)
> > +{
> > +     const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> > +
> > +     sun8i_pwm_waveform_to_ns(wfhw, wf);
>
> I suggest to rename that function to __sun8i_pwm_round_waveform_fromhw()
> or similar to make the relation between the two functions obvious.

Renamed to __sun8i_pwm_round_waveform_fromhw().

> > +     dev_dbg(pwmchip_parent(chip),
> > +             "pwm#%u: pair-rate=3D%u, div-k=3D%u, period=3D%u, duty=3D=
%u, bypass=3D%u, active-high=3D%u -> %llu/%llu [+%llu]\n",
> > +             pwm->hwpwm, wfhw->pair_rate, wfhw->div_k,
> > +             wfhw->period_ticks, wfhw->duty_ticks, wfhw->bypass_en,
> > +             wfhw->active_state,
> > +             wf->duty_length_ns, wf->period_length_ns,
> > +             wf->duty_offset_ns);
> > +
> > +     return 0;
> > +}
> > +
> > +static bool
> > +sun8i_pwm_pair_rate_constrained(struct sun8i_pwm_chip *sun8i_chip,
> > +                             unsigned int idx)
> > +{
> > +     unsigned int sibling =3D idx ^ 1;
> > +     unsigned long flags;
> > +     bool constrained;
> > +
> > +     if (sibling >=3D sun8i_chip->data->npwm)
> > +             return false;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     constrained =3D sun8i_chip->channels[sibling].mode =3D=3D
> > +                     SUN8I_PWM_MODE_CLK ||
> > +                   READ_ONCE(sun8i_chip->channels[sibling].rate_exclus=
ive) ||
> > +                   sun8i_pwm_channel_is_enabled_locked(sun8i_chip,
> > +                                                       sibling);
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return constrained;
> > +}
> > +
> > +static int sun8i_pwm_clear_idle_deadzone(struct sun8i_pwm_chip *sun8i_=
chip,
> > +                                      unsigned int idx)
> > +{
> > +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(idx);
> > +     unsigned long flags;
> > +     u32 pdzcr, per;
> > +     int ret =3D 0;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
> > +     if (!(pdzcr & SUN8I_PWM_PDZCR_ENABLE))
> > +             goto out_unlock;
> > +
> > +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     if (per & sun8i_pwm_pair_enable_mask(sun8i_chip, pair)) {
> > +             ret =3D -EOPNOTSUPP;
> > +             goto out_unlock;
> > +     }
> > +
> > +     pdzcr &=3D ~SUN8I_PWM_PDZCR_ENABLE;
> > +     sun8i_pwm_writel(sun8i_chip, pdzcr, SUN8I_PWM_PDZCR(pair));
> > +
> > +out_unlock:
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static u64 sun8i_pwm_max_period_ns(struct sun8i_pwm_chip *sun8i_chip,
> > +                                unsigned int idx)
> > +{
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[idx];
> > +     unsigned long flags, pair_rate;
> > +     u32 pcr;
> > +     u16 div_k;
> > +
> > +     pair_rate =3D clk_get_rate(chan->pair_clk);
> > +     if (!pair_rate || pair_rate > U32_MAX)
> > +             return 0;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(idx));
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +     div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pcr) + 1;
> > +
> > +     return sun8i_pwm_ticks_to_ns(SUN8I_PWM_PPR_PERIOD_MAX, div_k,
> > +                                  pair_rate);
> > +}
> > +
> > +static int sun8i_pwm_wait_period_ready(struct sun8i_pwm_chip *sun8i_ch=
ip,
> > +                                    unsigned int idx, u64 *timeout_us)
> > +{
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[idx];
> > +     unsigned long poll_us;
> > +     u64 period_ns;
> > +     u32 val;
> > +     int ret;
> > +
> > +     /* PPR contains the pending value, not necessarily the active per=
iod. */
> > +     period_ns =3D chan->pending_period_ns;
> > +     if (!period_ns)
> > +             period_ns =3D sun8i_pwm_max_period_ns(sun8i_chip, idx);
> > +     *timeout_us =3D DIV_ROUND_UP_ULL(period_ns, NSEC_PER_USEC) +
> > +                   SUN8I_PWM_PERIOD_READY_MARGIN_US;
> > +     poll_us =3D clamp_t(u64,
> > +                       DIV_ROUND_UP_ULL(*timeout_us,
> > +                                        SUN8I_PWM_PERIOD_READY_POLL_CO=
UNT),
> > +                       SUN8I_PWM_PERIOD_READY_MIN_POLL_US,
> > +                       SUN8I_PWM_PERIOD_READY_MAX_POLL_US);
> > +
> > +     ret =3D readl_poll_timeout(sun8i_chip->base + SUN8I_PWM_PCR(idx),=
 val,
> > +                              !(val & SUN8I_PWM_PCR_PERIOD_READY), pol=
l_us,
> > +                              *timeout_us);
> > +     if (!ret)
> > +             chan->pending_period_ns =3D 0;
> > +
> > +     return ret;
> > +}
> > +
> > +static int sun8i_pwm_write_waveform(struct pwm_chip *chip,
> > +                                 struct pwm_device *pwm, const void *_=
wfhw)
> > +{
> > +     const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> > +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwp=
wm];
> > +     struct device *dev =3D pwmchip_parent(chip);
> > +     unsigned long bus_rate, current_rate, restored_rate;
> > +     unsigned long flags;
> > +     u64 new_ns, old_ns, timeout_us;
> > +     bool acquired_exclusive =3D false;
> > +     bool can_restore_enable =3D true;
> > +     bool current_bypass, needs_quiesce, was_enabled;
> > +     u16 current_div_k;
> > +     u32 old_ticks, pcr, ppr, val;
> > +     int restore_ret, ret;
> > +
> > +     if (!wfhw->enabled) {
> > +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, fals=
e);
> > +             sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false=
);
> > +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +             if (READ_ONCE(chan->rate_exclusive)) {
> > +                     clk_rate_exclusive_put(chan->pair_clk);
> > +                     WRITE_ONCE(chan->rate_exclusive, false);
> > +             }
> > +
> > +             return 0;
> > +     }
> > +
> > +     if (!wfhw->pair_rate ||
> > +         (!wfhw->bypass_en &&
> > +          (!wfhw->div_k || wfhw->div_k > 256 ||
> > +           !wfhw->period_ticks ||
> > +           wfhw->period_ticks > SUN8I_PWM_PPR_PERIOD_MAX ||
> > +           wfhw->duty_ticks > FIELD_MAX(SUN8I_PWM_PPR_DUTY_MASK))))
> > +             return -EINVAL;
> > +
> > +     if (!wfhw->bypass_en) {
> > +             ret =3D sun8i_pwm_clear_idle_deadzone(sun8i_chip, pwm->hw=
pwm);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     current_rate =3D clk_get_rate(chan->pair_clk);
> > +     if (!current_rate || current_rate > U32_MAX)
> > +             return -ERANGE;
> > +     bus_rate =3D clk_get_rate(sun8i_chip->bus_clk);
> > +
> > +     if (!wfhw->bypass_en) {
> > +             /* Do not overwrite a PPR update which has not latched ye=
t. */
> > +             ret =3D sun8i_pwm_wait_period_ready(sun8i_chip, pwm->hwpw=
m,
> > +                                               &timeout_us);
> > +             if (ret) {
> > +                     dev_err_ratelimited(dev, "pwm#%u: update timeout =
after %llu us\n",
> > +                                         pwm->hwpwm, timeout_us);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     was_enabled =3D sun8i_pwm_channel_is_enabled_locked(sun8i_chip,
> > +                                                       pwm->hwpwm);
> > +     val =3D sun8i_pwm_readl(sun8i_chip,
> > +                           SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(pwm->hwpw=
m)));
> > +     current_bypass =3D !!(val &
> > +                                BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pwm->hwp=
wm)));
> > +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm));
> > +     ppr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm));
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +     current_div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pcr) + =
1;
> > +
> > +     if (current_rate !=3D wfhw->pair_rate &&
> > +         sun8i_pwm_pair_rate_constrained(sun8i_chip, pwm->hwpwm))
> > +             return -EBUSY;
> > +
> > +     if (was_enabled && !READ_ONCE(chan->rate_exclusive)) {
> > +             ret =3D clk_rate_exclusive_get(chan->pair_clk);
> > +             if (ret)
> > +                     return ret;
> > +             WRITE_ONCE(chan->rate_exclusive, true);
> > +     }
> > +
> > +     /*
> > +      * Updating PPR while running is safe only if the input clocks an=
d
> > +      * polarity remain unchanged and PCLK is faster than the PWM cloc=
k.
> > +      * Otherwise stop the channel before touching its configuration.
> > +      */
> > +     needs_quiesce =3D was_enabled &&
> > +             (current_bypass !=3D wfhw->bypass_en ||
> > +              current_rate !=3D wfhw->pair_rate ||
> > +              (!wfhw->bypass_en &&
> > +               (!!(pcr & SUN8I_PWM_PCR_ACTIVE_STATE) !=3D
> > +                wfhw->active_state ||
> > +                current_div_k !=3D wfhw->div_k ||
> > +                (pcr & SUN8I_PWM_PCR_MODE) ||
> > +                !bus_rate ||
> > +                bus_rate <=3D DIV_ROUND_UP_ULL(wfhw->pair_rate,
> > +                                                  wfhw->div_k))));
> > +
> > +     if (needs_quiesce) {
> > +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, fals=
e);
> > +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +     }
> > +
> > +     if (!was_enabled && !READ_ONCE(chan->rate_exclusive)) {
> > +             if (current_rate =3D=3D wfhw->pair_rate)
> > +                     ret =3D clk_rate_exclusive_get(chan->pair_clk);
> > +             else
> > +                     ret =3D clk_set_rate_exclusive(chan->pair_clk,
> > +                                                  wfhw->pair_rate);
> > +             if (ret)
> > +                     return ret;
> > +             WRITE_ONCE(chan->rate_exclusive, true);
> > +             acquired_exclusive =3D true;
> > +     } else if (current_rate !=3D wfhw->pair_rate) {
> > +             ret =3D clk_set_rate(chan->pair_clk, wfhw->pair_rate);
> > +             if (ret)
> > +                     goto restore_enable;
> > +     }
> > +
> > +     if (clk_get_rate(chan->pair_clk) !=3D wfhw->pair_rate) {
> > +             ret =3D -EINVAL;
> > +             goto restore_rate;
> > +     }
> > +
> > +     if (!wfhw->bypass_en) {
> > +             /* Return the channel to cycle mode without replaying W1S=
 bits. */
> > +             pcr &=3D ~(SUN8I_PWM_PCR_PRESCAL_K_MASK |
> > +                      SUN8I_PWM_PCR_ACTIVE_STATE | SUN8I_PWM_PCR_MODE =
|
> > +                      SUN8I_PWM_PCR_PULSE_START |
> > +                      SUN8I_PWM_PCR_PERIOD_READY);
> > +             pcr |=3D FIELD_PREP(SUN8I_PWM_PCR_PRESCAL_K_MASK,
> > +                               wfhw->div_k - 1);
> > +             if (wfhw->active_state)
> > +                     pcr |=3D SUN8I_PWM_PCR_ACTIVE_STATE;
> > +             sun8i_pwm_writel(sun8i_chip, pcr, SUN8I_PWM_PCR(pwm->hwpw=
m));
> > +
> > +             val =3D SUN8I_PWM_PPR_DUTY(wfhw->duty_ticks);
> > +             val |=3D SUN8I_PWM_PPR_PERIOD(wfhw->period_ticks);
> > +             old_ns =3D 0;
> > +             if (was_enabled && !current_bypass) {
> > +                     old_ticks =3D SUN8I_PWM_PPR_PERIOD_VALUE(ppr);
> > +                     old_ns =3D sun8i_pwm_ticks_to_ns(old_ticks, curre=
nt_div_k,
> > +                                                    current_rate);
> > +             }
> > +             new_ns =3D sun8i_pwm_ticks_to_ns(wfhw->period_ticks,
> > +                                            wfhw->div_k, wfhw->pair_ra=
te);
> > +             chan->pending_period_ns =3D max(old_ns, new_ns);
> > +             sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PPR(pwm->hwpw=
m));
> > +     }
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, wfhw->bypass_=
en);
> > +     sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, true);
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     return 0;
> > +
> > +restore_rate:
> > +     if (current_rate !=3D wfhw->pair_rate) {
> > +             restore_ret =3D clk_set_rate(chan->pair_clk, current_rate=
);
> > +             restored_rate =3D clk_get_rate(chan->pair_clk);
> > +             if (restore_ret || restored_rate !=3D current_rate) {
> > +                     dev_err(dev,
> > +                             "pwm#%u: failed to restore pair clock rat=
e %lu: %d (got %lu)\n",
> > +                             pwm->hwpwm, current_rate, restore_ret,
> > +                             restored_rate);
> > +                     can_restore_enable =3D false;
> > +             }
> > +     }
> > +     if (acquired_exclusive) {
> > +             clk_rate_exclusive_put(chan->pair_clk);
> > +             WRITE_ONCE(chan->rate_exclusive, false);
> > +     }
> > +restore_enable:
> > +     if (needs_quiesce && can_restore_enable) {
> > +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, true=
);
> > +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +     }
> > +
> > +     return ret;
>
> For a function that is supposed to just write wfhw into the hardware
> that is really complicated. Is this really necessary?

There was avoidable complexity here. V9 encodes the channel register
values during waveform conversion and uses one preparation helper for
rate protection, quiescing and rollback. The write callback then applies
those values, without the redundant private-field validation.

I kept the pending-period handshake and the checks for whether an update
can safely run live. Clock, prescaler, polarity and bypass transitions
may require stopping the output. After a failed rate change, restarting
it also requires restoring the old clock first; otherwise the old
register values could produce a different waveform.

> > +}
> > +
> > +struct sun8i_pwm_rounding {
> > +     const struct pwm_waveform *requested;
> > +     struct sun8i_pwm_waveform best;
> > +     struct pwm_waveform best_wf;
> > +     u32 current_pair_rate;
> > +     bool have_best;
> > +};
> > +
> > +static bool
> > +sun8i_pwm_candidate_is_better(const struct sun8i_pwm_rounding *roundin=
g,
> > +                           const struct sun8i_pwm_waveform *candidate,
> > +                           const struct pwm_waveform *candidate_wf)
> > +{
> > +     const struct pwm_waveform *requested =3D rounding->requested;
> > +     bool candidate_period_down, best_period_down;
> > +
> > +     /* A zero-duty, zero-offset cycle-mode candidate always exists. *=
/
> > +     if (candidate_wf->duty_length_ns > requested->duty_length_ns ||
> > +         candidate_wf->duty_offset_ns > requested->duty_offset_ns)
> > +             return false;
> > +
> > +     if (!rounding->have_best)
> > +             return true;
> > +
> > +     candidate_period_down =3D
> > +             candidate_wf->period_length_ns <=3D requested->period_len=
gth_ns;
> > +     best_period_down =3D
> > +             rounding->best_wf.period_length_ns <=3D requested->period=
_length_ns;
> > +     if (candidate_period_down !=3D best_period_down)
> > +             return candidate_period_down;
> > +
> > +     if (candidate_wf->period_length_ns !=3D
> > +         rounding->best_wf.period_length_ns) {
> > +             if (candidate_period_down)
> > +                     return candidate_wf->period_length_ns >
> > +                            rounding->best_wf.period_length_ns;
> > +
> > +             return candidate_wf->period_length_ns <
> > +                    rounding->best_wf.period_length_ns;
> > +     }
> > +
> > +     if (candidate_wf->duty_length_ns !=3D
> > +         rounding->best_wf.duty_length_ns)
> > +             return candidate_wf->duty_length_ns >
> > +                    rounding->best_wf.duty_length_ns;
> > +
> > +     if (candidate_wf->duty_offset_ns !=3D
> > +         rounding->best_wf.duty_offset_ns)
> > +             return candidate_wf->duty_offset_ns >
> > +                    rounding->best_wf.duty_offset_ns;
> > +
> > +     /* Avoid a shared pair-rate change when two settings are equivale=
nt. */
> > +     return candidate->pair_rate =3D=3D rounding->current_pair_rate &&
> > +            rounding->best.pair_rate !=3D rounding->current_pair_rate;
> > +}
> > +
> > +static void
> > +sun8i_pwm_consider_candidate(struct sun8i_pwm_rounding *rounding,
> > +                          const struct sun8i_pwm_waveform *candidate)
> > +{
> > +     struct pwm_waveform candidate_wf;
> > +
> > +     sun8i_pwm_waveform_to_ns(candidate, &candidate_wf);
> > +     if (!sun8i_pwm_candidate_is_better(rounding, candidate,
> > +                                        &candidate_wf))
> > +             return;
> > +
> > +     rounding->best =3D *candidate;
> > +     rounding->best_wf =3D candidate_wf;
> > +     rounding->have_best =3D true;
> > +}
> > +
> > +static void
> > +sun8i_pwm_consider_normal(struct sun8i_pwm_rounding *rounding, u32 pai=
r_rate,
> > +                       u16 div_k)
> > +{
> > +     const struct pwm_waveform *requested =3D rounding->requested;
> > +     struct sun8i_pwm_waveform candidate =3D {
> > +             .enabled =3D true,
> > +             .pair_rate =3D pair_rate,
> > +             .div_k =3D div_k,
> > +     };
> > +     u64 denominator =3D NSEC_PER_SEC * (u64)div_k;
> > +     u64 duty_ticks, period_ticks;
> > +     u64 duty_ns =3D requested->duty_length_ns;
> > +     u64 period_ns =3D requested->period_length_ns;
> > +     u32 inactive_ticks;
> > +
> > +     period_ticks =3D mul_u64_u64_div_u64(period_ns, pair_rate, denomi=
nator);
> > +     period_ticks =3D clamp_t(u64, period_ticks, 1, SUN8I_PWM_PPR_PERI=
OD_MAX);
> > +     candidate.period_ticks =3D period_ticks;
> > +     if (candidate.period_ticks > 1 &&
> > +         sun8i_pwm_ticks_to_ns(candidate.period_ticks, div_k, pair_rat=
e) >
> > +         requested->period_length_ns)
> > +             candidate.period_ticks--;
> > +
> > +     duty_ticks =3D mul_u64_u64_div_u64(duty_ns, pair_rate, denominato=
r);
> > +     duty_ticks =3D min_t(u64, duty_ticks, candidate.period_ticks);
> > +     if (duty_ticks &&
> > +         sun8i_pwm_ticks_to_ns(duty_ticks, div_k, pair_rate) >
> > +         requested->duty_length_ns)
> > +             duty_ticks--;
> > +
> > +     /*
> > +      * Zero active ticks encode either constant level. For a toggling
> > +      * waveform, active-low mode places the rising edge after the ina=
ctive
> > +      * part, which is the only non-zero offset supported by the hardw=
are.
> > +      */
> > +     if (!duty_ticks) {
> > +             candidate.active_state =3D true;
> > +             candidate.duty_ticks =3D 0;
> > +     } else if (duty_ticks =3D=3D candidate.period_ticks) {
> > +             candidate.active_state =3D false;
> > +             candidate.duty_ticks =3D 0;
> > +     } else {
> > +             inactive_ticks =3D candidate.period_ticks - duty_ticks;
> > +             if (sun8i_pwm_ticks_to_ns(inactive_ticks, div_k, pair_rat=
e) <=3D
> > +                 requested->duty_offset_ns) {
> > +                     candidate.active_state =3D false;
> > +                     candidate.duty_ticks =3D inactive_ticks;
> > +             } else {
> > +                     candidate.active_state =3D true;
> > +                     candidate.duty_ticks =3D duty_ticks;
> > +             }
> > +     }
> > +
> > +     sun8i_pwm_consider_candidate(rounding, &candidate);
> > +}
> > +
> > +static void
> > +sun8i_pwm_consider_pair_rate(struct sun8i_pwm_rounding *rounding,
> > +                          u32 pair_rate)
> > +{
> > +     struct sun8i_pwm_waveform bypass =3D {
> > +             .duty_ticks =3D 1,
> > +             .period_ticks =3D 1,
> > +             .pair_rate =3D pair_rate,
> > +             .div_k =3D 1,
> > +             .enabled =3D true,
> > +             .active_state =3D true,
> > +             .bypass_en =3D true,
> > +     };
> > +
> > +     for (unsigned int div_k =3D 1; div_k <=3D 256; div_k++)
> > +             sun8i_pwm_consider_normal(rounding, pair_rate, div_k);
> > +
> > +     sun8i_pwm_consider_candidate(rounding, &bypass);
> > +}
> > +
> > +static int sun8i_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > +                                      struct pwm_device *pwm,
> > +                                      const struct pwm_waveform *wf,
> > +                                      void *_wfhw)
> > +{
> > +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> > +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwp=
wm];
> > +     struct sun8i_pwm_pair *pair =3D
> > +             &sun8i_chip->pairs[SUN8I_PWM_PAIR_IDX(pwm->hwpwm)];
> > +     struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> > +     struct sun8i_pwm_rounding rounding =3D {
> > +             .requested =3D wf,
> > +     };
> > +     unsigned long current_rate;
> > +
> > +     if (!wf->period_length_ns) {
> > +             *wfhw =3D (struct sun8i_pwm_waveform) {
> > +                     .enabled =3D false,
> > +             };
> > +             return 0;
> > +     }
> > +
> > +     current_rate =3D clk_get_rate(chan->pair_clk);
> > +     if (!current_rate || current_rate > U32_MAX)
> > +             return -ERANGE;
> > +     rounding.current_pair_rate =3D current_rate;
> > +
> > +     if (sun8i_pwm_pair_rate_constrained(sun8i_chip, pwm->hwpwm)) {
> > +             sun8i_pwm_consider_pair_rate(&rounding, current_rate);
>
> These consider functions make an over-engineered impression on me. Over
> all I have the impression this driver is more complicated than
> necessary. I didn't recheck on Richard's previous iteration, but that
> seemed simpler (read: better) to me.

The fixed-rate/divider conversion is now a pure helper, and candidate
comparison and selection use one function. The redundant corrective
rounding steps are gone too.

I retained the bounded search across parents, dividers and bypass so the
choice follows the period, duty and offset ordering rather than a
preferred-parent heuristic. It still handles inverted waveforms,
constant levels and the 65536-tick period boundary.

> > +     } else {
> > +             for (unsigned int parent_idx =3D 0;
> > +                  parent_idx < clk_hw_get_num_parents(pair->hw);
> > +                  parent_idx++) {
> > +                     struct clk_hw *parent;
> > +                     unsigned long parent_rate;
> > +
> > +                     parent =3D clk_hw_get_parent_by_index(pair->hw, p=
arent_idx);
> > +                     if (!parent)
> > +                             continue;
> > +                     parent_rate =3D clk_hw_get_rate(parent);
> > +                     if (!parent_rate)
> > +                             continue;
> > +
> > +                     for (unsigned int i =3D 0; sun8i_pwm_div_m_table[=
i].div;
> > +                          i++) {
> > +                             u16 div_m =3D sun8i_pwm_div_m_table[i].di=
v;
> > +                             u64 pair_rate;
> > +
> > +                             pair_rate =3D DIV_ROUND_UP_ULL(parent_rat=
e, div_m);
> > +                             if (!pair_rate || pair_rate > U32_MAX)
> > +                                     continue;
> > +                             sun8i_pwm_consider_pair_rate(&rounding, p=
air_rate);
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (!rounding.have_best)
> > +             return -EINVAL;
> > +     *wfhw =3D rounding.best;
> > +
> > +     dev_dbg(pwmchip_parent(chip),
> > +             "pwm#%u: %llu/%llu [+%llu] -> pair-rate=3D%u, div-k=3D%u,=
 period=3D%u, duty=3D%u, bypass=3D%u, active-high=3D%u\n",
> > +             pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns,
> > +             wf->duty_offset_ns, wfhw->pair_rate, wfhw->div_k,
> > +             wfhw->period_ticks, wfhw->duty_ticks, wfhw->bypass_en,
> > +             wfhw->active_state);
> > +
> > +     return rounding.best_wf.period_length_ns > wf->period_length_ns;
> > +}
> > +
> > +static const struct pwm_ops sun8i_pwm_ops =3D {
> > +     .request =3D sun8i_pwm_request,
> > +     .free =3D sun8i_pwm_free,
> > +     .sizeof_wfhw =3D sizeof(struct sun8i_pwm_waveform),
> > +     .round_waveform_tohw =3D sun8i_pwm_round_waveform_tohw,
> > +     .round_waveform_fromhw =3D sun8i_pwm_round_waveform_fromhw,
> > +     .read_waveform =3D sun8i_pwm_read_waveform,
> > +     .write_waveform =3D sun8i_pwm_write_waveform,
> > +};
> > +
> > +/* Register the shared mux, gate and /div_m clock for each channel pai=
r. */
> > +static int sun8i_pwm_register_pair_clocks(struct device *dev,
> > +                                       struct sun8i_pwm_chip *sun8i_ch=
ip)
> > +{
> > +     static const struct clk_parent_data parent_data[] =3D {
> > +             { .index =3D 0 },
> > +             { .index =3D 1 },
> > +     };
> > +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npwm, 2=
);
> > +
> > +     for (unsigned int i =3D 0; i < num_pairs; i++) {
> > +             struct sun8i_pwm_pair *pair =3D &sun8i_chip->pairs[i];
> > +             void __iomem *reg =3D sun8i_chip->base + SUN8I_PWM_PCCR(i=
);
> > +             struct clk *pair_clk;
> > +             const char *name;
> > +             int ret;
> > +
> > +             name =3D devm_kasprintf(dev, GFP_KERNEL,
> > +                                   "%s#pwm-clk-src%u%u", dev_name(dev)=
,
> > +                                    i * 2, i * 2 + 1);
> > +             if (!name)
> > +                     return -ENOMEM;
> > +
> > +             pair->mux.reg =3D reg;
> > +             pair->mux.shift =3D SUN8I_PWM_PCCR_SRC_SHIFT;
> > +             pair->mux.mask =3D SUN8I_PWM_PCCR_SRC_MASK;
> > +             pair->mux.flags =3D CLK_MUX_ROUND_CLOSEST;
> > +             pair->mux.lock =3D &sun8i_chip->lock;
> > +
> > +             pair->chip =3D sun8i_chip;
> > +             pair->index =3D i;
> > +
> > +             pair->divider.reg =3D reg;
> > +             pair->divider.shift =3D SUN8I_PWM_PCCR_DIV_M_SHIFT;
> > +             pair->divider.width =3D SUN8I_PWM_PCCR_DIV_M_WIDTH;
> > +             pair->divider.table =3D sun8i_pwm_div_m_table;
> > +             pair->divider.lock =3D &sun8i_chip->lock;
> > +
> > +             pair->hw =3D devm_clk_hw_register_composite_pdata(dev, na=
me,
> > +                                                             parent_da=
ta,
> > +                                                             ARRAY_SIZ=
E(parent_data),
> > +                     &pair->mux.hw, &clk_mux_ops,
> > +                     &pair->divider.hw, &clk_divider_ops,
> > +                     &pair->gate_hw, &sun8i_pwm_pair_gate_ops, 0);
> > +             if (IS_ERR(pair->hw))
> > +                     return dev_err_probe(dev, PTR_ERR(pair->hw),
> > +                                          "Failed to register pair %u =
clock\n", i);
> > +
> > +             pair_clk =3D devm_clk_hw_get_clk(dev, pair->hw, NULL);
> > +             if (IS_ERR(pair_clk))
> > +                     return dev_err_probe(dev, PTR_ERR(pair_clk),
> > +                                          "Failed to get pair %u clock=
\n", i);
> > +
> > +             pair->rate_nb.notifier_call =3D sun8i_pwm_pair_rate_notif=
ier;
> > +             ret =3D devm_clk_notifier_register(dev, pair_clk, &pair->=
rate_nb);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "Failed to protect pair %u c=
lock rate\n", i);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/* Register a pair-clock consumer and the bypass clock for each channe=
l. */
> > +static int sun8i_pwm_register_channel_clocks(struct device *dev,
> > +                                          struct sun8i_pwm_chip *sun8i=
_chip)
> > +{
> > +     for (unsigned int i =3D 0; i < sun8i_chip->data->npwm; i++) {
> > +             struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[=
i];
> > +             struct clk_hw *parent =3D sun8i_chip->pairs[SUN8I_PWM_PAI=
R_IDX(i)].hw;
> > +             struct clk_parent_data parent_data =3D { .hw =3D parent }=
;
> > +             struct clk_init_data init =3D {};
> > +             const char *name;
> > +             int ret;
> > +
> > +             /* Separate handles let CCF arbitrate sibling rate exclus=
ivity. */
> > +             chan->pair_clk =3D devm_clk_hw_get_clk(dev, parent, NULL)=
;
> > +             if (IS_ERR(chan->pair_clk))
> > +                     return dev_err_probe(dev, PTR_ERR(chan->pair_clk)=
,
> > +                                          "Failed to get pair clock fo=
r PWM %u\n", i);
> > +
> > +             name =3D devm_kasprintf(dev, GFP_KERNEL, "%s#pwm-bypass%u=
",
> > +                                   dev_name(dev), i);
> > +             if (!name)
> > +                     return -ENOMEM;
> > +
> > +             chan->bypass.chip =3D sun8i_chip;
> > +             chan->bypass.index =3D i;
> > +             init.name =3D name;
> > +             init.ops =3D &sun8i_pwm_bypass_ops;
> > +             init.parent_data =3D &parent_data;
> > +             init.num_parents =3D 1;
> > +             /* Keep the shared pair rate stable for the prepared life=
time. */
> > +             init.flags =3D CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE;
> > +             chan->bypass.hw.init =3D &init;
> > +
> > +             ret =3D devm_clk_hw_register(dev, &chan->bypass.hw);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "Failed to register bypass c=
lock %u\n", i);
> > +
> > +             sun8i_chip->hw_data->hws[i] =3D &chan->bypass.hw;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * A disabled pair gate makes any set PER bits ineffective. Clear thos=
e stale
> > + * enables before a clock consumer can turn the shared gate on and exp=
ose an
> > + * unrequested output.
> > + */
> > +static void
> > +sun8i_pwm_sanitize_disabled_pairs(struct sun8i_pwm_chip *sun8i_chip)
> > +{
> > +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npwm, 2=
);
> > +     unsigned long flags;
> > +     u32 per;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> > +             unsigned int first =3D pair * 2;
> > +             u32 pccr;
> > +
> > +             pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair)=
);
> > +             if (pccr & SUN8I_PWM_PCCR_GATE)
> > +                     continue;
> > +
> > +             per &=3D ~SUN8I_PWM_ENABLE(first);
> > +             pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first));
> > +             if (first + 1 < sun8i_chip->data->npwm) {
> > +                     per &=3D ~SUN8I_PWM_ENABLE(first + 1);
> > +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first + =
1));
> > +             }
> > +             sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pair));
> > +     }
> > +     sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +}
> > +
> > +/*
> > + * Keep firmware-active outputs running until all declared consumers h=
ave had
> > + * a chance to claim them. Once the driver core calls sync_state(), an=
y channel
> > + * which still has no PWM or clock owner can be stopped.
>
> Never saw that callback before, I hesitate to like it. The idea is to
> disable the PWMs if there is no consumer after boot-up? If this is
> considered a good idea, I'd prefer to do that at the pwm core level for
> all drivers/devices in the same way.

Removed sync_state() and the driver-local unclaimed-output shutdown
policy. V9 leaves firmware-active outputs running until a consumer
changes them, while retaining the hardware-enable checks which protect
their shared gate and rate.

> > + */
> > +static void sun8i_pwm_sync_state(struct device *dev)
> > +{
> > +     struct sun8i_pwm_chip *sun8i_chip =3D dev_get_drvdata(dev);
> > +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npwm, 2=
);
> > +     unsigned long empty_pairs =3D 0;
> > +     unsigned long flags;
> > +     u32 active, per, unclaimed =3D 0;
> > +
> > +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> > +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> > +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> > +             u32 pair_mask =3D sun8i_pwm_pair_enable_mask(sun8i_chip, =
pair);
> > +             u32 owner_mask;
> > +             u32 pdzcr;
> > +
> > +             owner_mask =3D sun8i_pwm_pair_owner_mask_locked(sun8i_chi=
p, pair);
> > +             pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pai=
r));
> > +             /* Dead-zone mode couples both outputs into one waveform.=
 */
> > +             if ((pdzcr & SUN8I_PWM_PDZCR_ENABLE) &&
> > +                 (per & owner_mask))
> > +                     continue;
> > +
> > +             unclaimed |=3D pair_mask & ~owner_mask;
> > +     }
> > +
> > +     active =3D per & unclaimed;
> > +     per &=3D ~unclaimed;
> > +     sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
> > +
> > +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> > +             unsigned int first =3D pair * 2;
> > +             u32 pccr;
> > +
> > +             pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair)=
);
> > +             if (unclaimed & SUN8I_PWM_ENABLE(first))
> > +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first));
> > +             if (first + 1 < sun8i_chip->data->npwm &&
> > +                 unclaimed & SUN8I_PWM_ENABLE(first + 1))
> > +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first + =
1));
> > +             sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pair));
> > +
> > +             if (!(per & sun8i_pwm_pair_enable_mask(sun8i_chip, pair))=
)
> > +                     empty_pairs |=3D BIT(pair);
> > +     }
> > +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> > +
> > +     /*
> > +      * Reconcile empty pair gates through CCF. Taking and dropping a
> > +      * temporary reference leaves a gate with another CCF user enable=
d, but
> > +      * disables a firmware-enabled gate whose software count is still=
 zero.
> > +      */
> > +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> > +             struct clk *pair_clk;
> > +             int ret;
> > +
> > +             if (!(empty_pairs & BIT(pair)))
> > +                     continue;
> > +
> > +             pair_clk =3D sun8i_chip->channels[pair * 2].pair_clk;
> > +             ret =3D clk_prepare_enable(pair_clk);
> > +             if (ret) {
> > +                     dev_warn(dev, "Failed to synchronize pair %u gate=
: %pe\n",
> > +                              pair, ERR_PTR(ret));
> > +                     continue;
> > +             }
> > +             clk_disable_unprepare(pair_clk);
> > +     }
> > +
> > +     if (active)
> > +             dev_dbg(dev, "disabled unclaimed firmware outputs %#x\n",=
 active);
> > +}
> > +
> > +static int sun8i_pwm_init_clocks(struct device *dev,
> > +                              struct sun8i_pwm_chip *sun8i_chip)
> > +{
> > +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npwm, 2=
);
> > +     size_t hw_data_size;
> > +     int ret;
> > +
> > +     sun8i_chip->pairs =3D devm_kcalloc(dev, num_pairs,
> > +                                      sizeof(*sun8i_chip->pairs), GFP_=
KERNEL);
> > +     if (!sun8i_chip->pairs)
> > +             return -ENOMEM;
> > +
> > +     hw_data_size =3D struct_size(sun8i_chip->hw_data, hws,
> > +                                sun8i_chip->data->npwm);
> > +     sun8i_chip->hw_data =3D devm_kzalloc(dev, hw_data_size, GFP_KERNE=
L);
> > +     if (!sun8i_chip->hw_data)
> > +             return -ENOMEM;
>
> Can you fold these allocations into a single one (that is, have
> devm_pwmchip_alloc() as only allocation call)? That should give better
> cache locality and reduce fragmentation.

The three pair objects and six channel objects are now embedded in the
private structure allocated by devm_pwmchip_alloc(). The separate onecell
table is gone; clock lookup uses the channel array directly. Clock-name
allocations and CCF's own allocations remain.

> > +     sun8i_chip->hw_data->num =3D sun8i_chip->data->npwm;
> > +     sun8i_pwm_sanitize_disabled_pairs(sun8i_chip);
> > +
> > +     ret =3D sun8i_pwm_register_pair_clocks(dev, sun8i_chip);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sun8i_pwm_register_channel_clocks(dev, sun8i_chip);
> > +}
> > +
> > +static int sun8i_pwm_probe(struct platform_device *pdev)
> > +{
> > +     const struct sun8i_pwm_data *data;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct sun8i_pwm_chip *sun8i_chip;
> > +     struct reset_control *rst;
> > +     struct pwm_chip *chip;
> > +     int ret;
> > +
> > +     data =3D of_device_get_match_data(dev);
> > +     if (!data)
> > +             return dev_err_probe(dev, -ENODEV,
> > +                                  "Missing specific data structure\n")=
;
> > +
> > +     chip =3D devm_pwmchip_alloc(dev, data->npwm, sizeof(*sun8i_chip))=
;
> > +     if (IS_ERR(chip))
> > +             return dev_err_probe(dev, PTR_ERR(chip),
> > +                                  "Failed to allocate pwmchip\n");
> > +
> > +     sun8i_chip =3D sun8i_pwm_from_chip(chip);
> > +     sun8i_chip->data =3D data;
> > +     spin_lock_init(&sun8i_chip->lock);
> > +     sun8i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(sun8i_chip->base))
> > +             return dev_err_probe(dev, PTR_ERR(sun8i_chip->base),
> > +                                  "Failed to get PWM base address\n");
> > +
> > +     sun8i_chip->bus_clk =3D devm_clk_get_enabled(dev, "bus");
> > +     if (IS_ERR(sun8i_chip->bus_clk))
> > +             return dev_err_probe(dev, PTR_ERR(sun8i_chip->bus_clk),
> > +                                  "Failed to get bus clock\n");
> > +
> > +     rst =3D devm_reset_control_get_shared_deasserted(dev, NULL);
> > +     if (IS_ERR(rst))
> > +             return dev_err_probe(dev, PTR_ERR(rst),
> > +                                  "Failed to get reset control\n");
> > +
> > +     sun8i_chip->channels =3D devm_kcalloc(dev, data->npwm,
> > +                                         sizeof(*sun8i_chip->channels)=
,
> > +                                         GFP_KERNEL);
> > +     if (!sun8i_chip->channels)
> > +             return dev_err_probe(dev, -ENOMEM,
> > +                                  "Failed to allocate %d channels arra=
y\n",
> > +                                  data->npwm);
> > +
> > +     chip->ops =3D &sun8i_pwm_ops;
> > +
> > +     ret =3D sun8i_pwm_init_clocks(dev, sun8i_chip);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                       sun8i_chip->hw_data);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to add HW clock pr=
ovider\n");
> > +
> > +     ret =3D devm_pwmchip_add(dev, chip);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Failed to add PWM chip\n"=
);
> > +
> > +     platform_set_drvdata(pdev, sun8i_chip);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct sun8i_pwm_data sun50i_h616_pwm_data =3D {
> > +     .npwm =3D 6,
>
> Are there new variants of that hardware already in the pipeline and
> these are known to differ by npwm only? If not, please hardcode that 6,
> or use a dt property (`npwms =3D <6>`). There is no need to do device
> variant handling if there is only a single variant.

Removed the single-variant match data and fixed the topology at six
channels. No npwms property is added.

>
> > +};
> > +
> > +static const struct of_device_id sun8i_pwm_dt_ids[] =3D {
> > +     {
> > +             .compatible =3D "allwinner,sun50i-h616-pwm",
> > +             .data =3D &sun50i_h616_pwm_data,
> > +     }, {
> > +             /* sentinel */
> > +     }
> > +};
> > +MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
> > +
> > +static struct platform_driver sun8i_pwm_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "sun8i-pwm",
> > +             .of_match_table =3D sun8i_pwm_dt_ids,
> > +             .sync_state =3D sun8i_pwm_sync_state,
> > +     },
> > +     .probe =3D sun8i_pwm_probe,
> > +};
> > +module_platform_driver(sun8i_pwm_driver);
> > +
> > +MODULE_AUTHOR("Richard Genoud <richard.genoud@bootlin.com>");
> > +MODULE_DESCRIPTION("Allwinner sun8i PWM driver");
> > +MODULE_LICENSE("GPL");
> >
> > --
> > 2.53.0
> >
