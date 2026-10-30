Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368329;
	b=G5+8AMY64522cEZL4wS4gOhYkUAeh9lYnfeFZjY5SCxXiyISETW+h69S1oKA65Rhgrgp
	 UhgbgEeFEsHW3dxjGxR6xo5bAYIUOXBJLM7m123Fm7GjIdNIiDElc1ytxVMjbHMU283Xj
	 I50HVxPPUViJYrYbxypv2+Fma4SuN8pCRo70Zbjz6nFXacmd4F3IvRTcHQIGCmhMl27xu
	 5LblBjJ+qLKPWmihSuXWNwnGoVo6ptPd5v1BdnDzQIJNBUJM1rgempGi1FAZyhg3UV+C3
	 Yp1HqvUu8S2RFAE8wgfQNBLxuPAJZP5TrBAK1cGQMICX+LR/G72jni0km7GEZqcLBqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368329;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=rreqjXCuaDWJ3vSeRfN8yw7LxuY/EzKtao82LH4eM9g=;
	b=nDPFcK18gO9tPHDvRO+9jYurHsb4UrlFW1nOdNcetuy7ZwF+rLGXPZYxq8ybdUMTZJq7
	 X13ztQDtR+tEyM6IR3E/tRLBbSD5VkaT6tMi/FL4tsxibOUsIiQT84IMIGfwIS/u2HSHf
	 XcjjoGdw/TVt/S0XKkmwD1G+4fz+tQ35arY/faG2wpEG42kgo+wbzvmKrt9qYw4/O/a/5
	 kc6rOWhPgRBW5frIrnb4GJQeAFWL+xGfNmrg2DSiQVmknDVwkRp7dM8/u9pCqa0O3gEuS
	 XR/mQwe6KvyYc2HGCVUha9xxjCNAfl5H2mxS1jMJ8kD7V8YLhuGe48gcRzpuAgzvMIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E9606A32A
	for <linux-pwm@vger.kernel.org>; Fri, 30 Oct 2026 13:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 746E9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eadef147ffso647970e0c.3
        for <linux-pwm@vger.kernel.org>; Fri, 30 Oct 2026 06:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368328; x=1793973128;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rreqjXCuaDWJ3vSeRfN8yw7LxuY/EzKtao82LH4eM9g=;
        b=UrHe9L3vtGU91UaiCBnKtGTFt4szPUgKKi7biwBtsd5hwQWRk8azjYq52Z5Nm/hWe9
         meO9E7onNaFGJXoiixh/DTEoq7FdAvpJSfk3ovhxAvhILyKetP3hZd+Sm+kc5HnpwYeA
         Eryxke3+74O6hwSCBlaZrAdhJPx79LkODGbesTMhOyiaLwfUjBuLpXpqmKRleiaHRkB9
         BJJFLRhiThYeTCfWeioj3fXmKIG9fTT1rVZAkeuuN/9Zz/nSI8sqUkVZ44XDZKNRumX6
         NJAju9D+gdUtsAOVkoQNn3heusGAISxOFtI/QWaTvPTP73VWGgQs4mJRUd2M4H5s8N0s
         NzgA==
X-Forwarded-Encrypted: i=1; AKwUvBzmcAdJtSNdJD5qAuqJWfUoDHgC928sAgp+WxxGMNaLBEHgPWa12SlSOyhetWkZhEmmc9/voFjI+Ro=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqNkC6vm7Ur2TPd0jak3zZYFFXAJ0+P+2GNpVGUQ3zEpaLAbkU
	VbVHzpv7KSquqohAbFC6eals5Y7ynT8BMlbhTIallRkRhhaz4Y/l0U7b6B66dWz2
X-Gm-Gg: AYBFou0FBCim6tTGy8GDTaM+C9Fjs0SKnrGjTc0iQ0jtC5IRamdHFM4T1neWAiHBNKE
	8CtuencDCa14wq5AwgUVqT05+Zv11dRCHW3UATbrRFGVeKAC7HATYKfR3MDD7ahj80m1Vcwk/p0
	KemI7oiASCsOuA0uhMHQagAw+n/p6HXD7Ob9iz6L3qD6KFBpmed1UlYz8Kyh2CLfAwh+RjXF6tg
	ptarUOxR1xsj7Ko4lTZerrvldRUC7clwGxgJblMTosEhsJTW8FATVYQ1iKQ09DJ5mXje509LsZJ
	R7jK8t00upUBJKPibFeegOpOvTW+//3jHngHB5qoTKpVrQtRFfTB3SrreCY6eN1/GSWErfVmuB/
	H3zNZm/go6VMpfFGa3RS6ObAjk/cr4ydZs6OlodFqsGpOE+25dWF9Jj5AXC1O6na/xzMKKySngC
	f+ZtxOZueAEMaI0PKjwxveEX45oyySY95nFZi3V0LPgv6ArV5QvibRQRVftfZBxXOQpaxKHVkI+
	YeRI6I8QIKJEAI7b2ScDzxRQqMGmwY/xHnEX7zGaUtbKt3tR1y17ur4VfjJth9cFu28JbqVd2xX
	B+LJrpDzddHCvtthqO0Z7oe4x5oZI9eCBDiQiOCEVwDOWJiuffzlnxiAzA33uXtiZGo=
X-Received: by 2002:a05:6122:3d0a:b0:5ea:bea1:706c with SMTP id 71dfb90a1353d-5ec68a173eemr1348726e0c.23.1793368328302;
        Fri, 30 Oct 2026 06:52:08 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bba011sm2453453e0c.5.2026.10.30.06.52.05
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:52:05 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7ccae9f1a9eso389950137.1
        for <linux-pwm@vger.kernel.org>; Fri, 30 Oct 2026 06:52:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxVZpd216YgMEIlzmbMVoTmQerQeKRpMacd+3QS/aMVd95Ua7NAu9+Pxh37xy6yMAYEUo8VbC0ETEY=@vger.kernel.org
X-Received: by 2002:a05:6102:160b:b0:7c2:7a0:ae28 with SMTP id
 ada2fe7eead31-7d072d2e3cemr1195876137.30.1793368325370; Fri, 30 Oct 2026
 06:52:05 -0700 (PDT)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793026273.git.geert+renesas@glider.be> <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
 <20261028132937.GL15441@killaraus.ideasonboard.com> <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
 <20261028163940.GA2673734@killaraus.ideasonboard.com> <CAMuHMdVOT+DTZum525kmYfP+jzzPrxMnEeRAkapxOMGz4XMHBA@mail.gmail.com>
 <20261030112314.GD2587681@killaraus.ideasonboard.com>
In-Reply-To: <20261030112314.GD2587681@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 14:51:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXR=dcooQoKwrycDpTaZjFk2CCueL08dYYFJLE9bP90cg@mail.gmail.com>
X-Gm-Features: AclHuK8hW4HdhOJ1AXkGa9vmPAzXpiaHAsOh7vH3ng5jr5l_XLCKj0-fmKWKS9c
Message-ID: <CAMuHMdXR=dcooQoKwrycDpTaZjFk2CCueL08dYYFJLE9bP90cg@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM clocks
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Fri, 30 Oct 2026 at 12:23, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Oct 29, 2026 at 10:08:28AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 28 Oct 2026 at 17:39, Laurent Pinchart wrote:
> > > On Wed, Oct 28, 2026 at 03:43:42PM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart wrote:
> > > > > On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > > > > > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> > > > > >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> > > > > >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > > > > > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> > > > > >
> > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > > > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > @@ -28,5 +28,8 @@
> > > > > >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> > > > > >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> > > > > >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > > > > > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > > > > > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
> > > > >
> > > > > Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> > > > > R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> > > > > dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> > > > > R8A78000_CPG_SGD16_PERW_BUS, as well as
> > > > > R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.
> > > >
> > > > I could add them, but do you have any need to refer to them from DT?
> > > > So far I only added clocks that are listed as clock supplies of on-SoC
> > > > modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
> > > > Timer Unit (TMU)).
> > >
> > > So we have two conflicting goals here. One of them is to only add clocks
> > > that we have validated to exist (and ideally work as documented). The
> > > other is to keep renesas,r8a78000-cpg.h readable. We won't be able to
> > > satisfy them both fully.
> > >
> > > I think we previously discussed adding whole groups of dividers in one
> > > go, as some sort of middle-ground approach. Those are clocks that are
> >
> > That is what did in this and the previous patch: we need
> >   - R8A78000_CPG_SGASYNCDn_PERW_MAIN for n=16, and added the one for
> >     n=8, too.
>
> That's missing n=4 and n=32. While SGASYNCD32 isn't referenced in the
> datasheet, SGASYNCD4 is (in SCIF and HSCIF). Maybe that's just an
> oversight ?

We already have the clocks for (H)SCIF (_BUS, not _MAIN!):

    #define R8A78000_CPG_SGASYNCD4_PERW_BUS         0
    #define R8A78000_CPG_SGASYNCD8_PERW_BUS         1

> >   - R8A78000_CPG_SCPBUSDn_SCP_MAIN for n=16, and added the ones for
> >     n=1,2,4,6,8,32, too.
> >   - R8A78000_CPG_S0Dn_PERE_MAIN for n=24, and added the ones for
> >     n=1,2,3,4,8, too.
> >   - R8A78000_CPG_SGDn_PERW_BUS for n=32, and added the ones for n=8,
> >     too.
> >
> > I did not includes clocks with values for n that exist according to
> > the documentation, but are not used as suppliers for modules.
> > Of course the documentation may be incorrect or incomplete, and we may
> > need to add them later. As IDs are ABI and the list is append-only,
> > they must be added at the end, which could indeed lead to not all
> > clocks of the same group being located together.  From an ABI point
> > of view that is OK, but from a human-readability point of view it is
> > indeed suboptimal.
> >
> > Before, we tended to add all clocks from the clock tables listed the
> > documentation upfront, ignoring clocks that are clearly internal-only.
> > Some of them turned out not to exist later.
> > Some new clocks had to be added when the documentation was updated.
> > Nothing new here, except that the list of clocks on R-Car X5H is an
> > order of magnitude longer.
> >
> > Note that we don't use a linear array of clocks indexed by clock ID
> > in the R-Car X5H CPG driver (yet), so large holes of unused clocks do
> > not hurt (they do hurt in the SCMI driver ;-)
> >
> > > not directly controllable. There's a risk of adding clocks that don't
> >
> > FTR, the xDn clocks are not directly controllable; clocks like
> > R8A78000_CPG_MSO_SCP_MAIN are.  We know the latter exist, as they
> > are used.
>
> Yes, I was talking about the clocks documented in the various
> non-PLL "hierarchy" sections.
>
> > > exist, or clocks that we won't need to reference from DT (because
> > > they're only used as parents of the MDLC-controlled module clock). Do
> >
> > The direct parent of an MDLC-controlled module clock should be in DT.
>
> An additional difficulty is that we don't actually know what clocks the
> MDLC gates :-/

This hasn't changed much: on other R-Car generations we also didn't
know which clock(s) are gated by a single MSTP (Module SToP) bit.
Historically (old SH parts), there was only a single clock supplying
each module. Modules on later SoCs gained more clock supplies.
Hence we always assumed (at least) the functional clock is gated by
the MSTP bit, and modelled the gateable SMTP clocks as a child of the
functional clock parent.  But it's quite possible other clock inputs
to the module are gated, too, depending on the actual module (some
modules e.g. need a PHY clock running to be able to process wake-up
events).

Comparing older R-Car with R-Car Gen5, I actually like how the new
MDLC block combines the power domain functionality of the old SYSC
block and the clock domain functionality of the old MSSR (Module Standby
and Software Reset) block. It improves upon the now imprecise modelling
of MSTP clocks, and maps nicely on the Linux PM Domain abstraction:
  - power domain: generic_pm_domain.power_{on,off}(domain),
  - clock domain: generic_pm_domain.dev_ops.{start,stop}(device).

> > Higher-up parents should not be needed iff the SCMI firmware exposed
> > and/or implements the proper clock hierarchy (which it does not at
> > the moment).
>
> A big *iff* :-)
>
> Even in that case, we'll have (at least) two issues:
>
> - Some modules may need to know the rate of the functional clock gated
>   by the MDLC. As those clocks are controlled through power domains,
>   they are only specified as the last cell of the power-domains
>   property, and are not listed in the clocks property. How do you
>   envision this to work ?

The functional clock (or its parent) is still listed in the clocks
property.  Compare e.g. the hscif0 nodes on R-Car V4H:

    clocks = <&cpg CPG_MOD 514>,
             <&cpg CPG_CORE R8A779G0_CLK_SASYNCPERD1>,
             <&scif_clk>;
    clock-names = "fck", "brg_int", "scif_clk";
    power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
    resets = <&cpg 514>;

and R-Car X5H:

    clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
             <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
             <&scif_clk>;
    clock-names = "fck", "brg_int", "scif_clk";
    power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x54>;
    resets = <&mdlc_perw 0x54>;

On R-Car V4H, MSTP514 aka "hscif0" is modelled as a gateable MSTP
clock with parent R8A779G0_CLK_SASYNCPERD1, and used as "fck".
On R-Car X5H, R8A78000_CPG_SGASYNCD4_PERW_BUS is used as "fck" directly.
Calling clk_get_rate() on MSTP514 and R8A78000_CPG_SGASYNCD4_PERW_BUS
gives similar results.

> - When multiple clocks derive from the same PLL, it's common for the PLL
>   rate to be specified through assigned-clock-rates. If we want to
>   continue doing that, we need to to make the whole clock hierarchy
>   available to DT.

Yes, you need a public ID to refer to a clock from DT.
Do you have an example where we would assigned-clock-rates it for a PLL?
So far all users of assigned-clock-rates on Renesas SoCs use it
on clocks that are already public as they are also needed as clock
supplies in clocks properties (e.g. CAN-FD and SPI reference clocks).

> > Still, they can be internal enum, starting after the last
> > DT clock, like we did in other R-Car clock drivers.
> >
> > > you think that's an issue, could it cause ABI problems in the future ?
> >
> > An ABI problem appears only when you refer in DT to a clock that does
> > not exist in hardware.  This should be caught by testing before the
> > DT user is added.
>
> So we could add e.g. SGASYNCD32 already, as long as we don't reference
> it in DT without testing.

We could, but which one: "_PERW_BUS" or "_PERW_MAIN"? Or both?
And what's the point if there are no users?

BTW, there are 87 SGD4_* clocks listed in the documentation.  They are
all sourced from the same PLL, and have all the same clock rate.
I don't think any of these can be gated.  Hence if I would write a
bare metal clock driver, I would just expose and instantiate a single
SGD4 clock.  But the current SCMI implementation exposes 87 different
clocks (and didn't make them usable by Linux until recently)...

Perhaps we should drop the domain suffixes from the definitions? Even
e.g. MSOCK_PERW_BUS and MSOCK_PERW_MAIN seem to be the same clock...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
