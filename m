Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265295;
	b=gAdsplUPDkcoHttUlIfev1qL2oEmFEmQK3jEnScLKlB/I2GCTyxWOXySUtsvEPRuRqcJ
	 XB/ae2U5sWk1P22cP9b/lnnjzCFc/Uk/Z71yTONnD3H6mGQj/T9KP2rVDxx/KzChpORsv
	 7pr08szJj35HmQZ/VPLoBLnv21ixfPbzHNeBzoP0fF0MM5aU7Q0S9NrCJwMgWupPPebaP
	 rsDIVd7UB+5u4kDlkaqs/cQOqcFgEBmM0KexmmpNZmijDIc866fOrly8qEev8sTU8R8hT
	 kHfgustQ5YGxRORi1EeC7T/D1oQioNm0X5ZiOFx3cD14ytrtzoY9vPXn4J/eiCG9KWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265295;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ZlsJgsuUxLshKsbZ0JGTcZhiSxa4IqXzGzYrO+oYcmo=;
	b=2/MLlk7WUeL3KrZo09uwofzBxovw00Ymi22eQMeX4loqHGfrG3LZE9gRmpSl2UNZzW1Q
	 QNehUN3kuifiTSdHRxhj4ffml584Z02wsXoNZFRhkHP8mf2w8VIVb3dpbvOuHEt9RGfwO
	 5vTPFufJ/D/6J0yNGHRrRotnPw4gtGRwckx8ANEWv3ZmWmSWx6W5u8UbZS4RwmI1GHpUB
	 IQ34C+kl0mn7usoVm0oN5rYloKOYO1JaiCxNNT3p8qOz6weBJfty2J3t+Ucw2jFvEWfrp
	 Ty27MeRGh0RWgPaldiuKiAbQri+y9ArnOh4t69TMOjD6FMtGet7rrUI7CCRHoyFANjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF58606A31C
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 09:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EF58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5367cc15121so27944291cf.0
        for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 02:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793265293; x=1793870093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZlsJgsuUxLshKsbZ0JGTcZhiSxa4IqXzGzYrO+oYcmo=;
        b=sb3hnlpmxehfEiabq/jtASUFfuzDH+2m1FIzPYTUwcXqvkihw2ZwtXKnnC4B6tX4S8
         0/9S/4jRb2+JeD7q8+PVUo5nryw/kGPe9+M3lvtg0vgtoKe5QsHHz3QLaftb3z2xcNL8
         Von0lQPBmMSDkOryvKnLv6/m+hUUlQImmp2Haafe3ZcI2iWMtCWlAYEZ4URYTHimknGI
         oKgvWT3YqOuQxbtIJMMirob47ScgGlVobRUkxSuGX0G3lVWDLJ7ii/OKGMdgH8c8lmHG
         SPPzYXR/jDfvxxfbwtMwY8LpAK40zx8jGp7PmFlFvEpthcD7ct6dpNJsNcsB2e2kCy/n
         gfTw==
X-Forwarded-Encrypted: i=1; AKwUvByhrtH9XHE+gg5bK8HxxU01UpZ1Wcsf+G+QxpWQADTNX7aFGicoJYFttaVad+6UfWzC6Y5Gjq8rka4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLV7LbZJ0GwSz5bU9Zc2x6nXKc3BJNPGwnnmoQuJ35AJqEBl+l
	UvlNHpv+9aTX6vVkkTQhAluSZtnO3fCSYGMLEwk+uU/fpF+UtaeO0XFSgp8I8z6v
X-Gm-Gg: AYBFou0hOlNjx4EnskPyYPKSzH2Q2iAWFEhe81e6nHhSng90wzO9mTi/IP8Xfi9NDTO
	YOjRgsNmznDQqDSVi3P24lgO1lLb5f60/4sa28lGXUFEXCxUzLbWaMLZ7UKHAxv25HmpRjz8Sj3
	MuydFx4a7EJD6KPUXwpG9YGNeMphYS3u98T6dn2NK1DJbcTvrRWtJ5kYoIXRlV3gVep59PoUYbj
	I424X9l1QcR+POSBruCRg9QD4/NiMTJcdduRYCGZLG6/F3gIS2OwJgNjw/1+vNdoX8mPEInQF2r
	3CzcqESVh0+fxQ/bWfNgi9xmD0drXVLY7nDQD5bfVr8N4QISCSYb+brkfrijp4xOURsu8YZsX5L
	+pI6VWYTlOHazGxXHi+xLpi/RdzypL87jDJCIoSqWK02G28btW4guOEaoipXrqUTmSkWl5k7J/i
	2+0CfxAXKsqauNy7KpIbbV4yBbXwr4s7Wtb/r7cHy11t7O+ay5hp95zXtQkaVIEBtjlMu1mF7TL
	xipZ8nLFWeFEPnO5m8vA3XnXw5rPDSMy6yKnbCwDAay1hAlDYQhcBFDtohlSsYD+izwdO3gDcfp
	Fi+gU65OIxwgXYod1iunzHQamaREmVGkNmnPsp28+NDp0v3pDQhgJEClesgkw0/5odKzdRG6PHx
	qr++oEnf+7VUTuQzL
X-Received: by 2002:a05:622a:248c:b0:532:abc9:8f4f with SMTP id d75a77b69052e-53fcbceb51fmr75596911cf.37.1793265293278;
        Thu, 29 Oct 2026 02:14:53 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c7e272e35sm41701236d6.1.2026.10.29.02.14.53
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 02:14:53 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f1cf92c9eso187777185a.0
        for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 02:14:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByUMEZuXki9VqzKVb1mzD2lqC+5Ujw6uCErMGo3E/lJEYCjXwhBzKr9fN/Lt1UKu8Keyj0vlRP8IGI=@vger.kernel.org
X-Received: by 2002:a05:6102:8357:10b0:7cd:3218:362e with SMTP id
 ada2fe7eead31-7d03a5d6043mr1694600137.29.1793264920555; Thu, 29 Oct 2026
 02:08:40 -0700 (PDT)
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
 <20261028163940.GA2673734@killaraus.ideasonboard.com>
In-Reply-To: <20261028163940.GA2673734@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2026 10:08:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOT+DTZum525kmYfP+jzzPrxMnEeRAkapxOMGz4XMHBA@mail.gmail.com>
X-Gm-Features: AclHuK9-UV4UizkhZLPxSnm2gBMXfy5lUX6jKfLRdtUVdpASkFCmlMNEyTp9nPg
Message-ID: <CAMuHMdVOT+DTZum525kmYfP+jzzPrxMnEeRAkapxOMGz4XMHBA@mail.gmail.com>
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

On Wed, 28 Oct 2026 at 17:39, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Oct 28, 2026 at 03:43:42PM +0100, Geert Uytterhoeven wrote:
> > On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart wrote:
> > > On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > > > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> > > >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> > > >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > > > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > @@ -28,5 +28,8 @@
> > > >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> > > >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> > > >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > > > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > > > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
> > >
> > > Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> > > R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> > > dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> > > R8A78000_CPG_SGD16_PERW_BUS, as well as
> > > R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.
> >
> > I could add them, but do you have any need to refer to them from DT?
> > So far I only added clocks that are listed as clock supplies of on-SoC
> > modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
> > Timer Unit (TMU)).
>
> So we have two conflicting goals here. One of them is to only add clocks
> that we have validated to exist (and ideally work as documented). The
> other is to keep renesas,r8a78000-cpg.h readable. We won't be able to
> satisfy them both fully.
>
> I think we previously discussed adding whole groups of dividers in one
> go, as some sort of middle-ground approach. Those are clocks that are

That is what did in this and the previous patch: we need
  - R8A78000_CPG_SGASYNCDn_PERW_MAIN for n=16, and added the one for
    n=8, too.
  - R8A78000_CPG_SCPBUSDn_SCP_MAIN for n=16, and added the ones for
    n=1,2,4,6,8,32, too.
  - R8A78000_CPG_S0Dn_PERE_MAIN for n=24, and added the ones for
    n=1,2,3,4,8, too.
  - R8A78000_CPG_SGDn_PERW_BUS for n=32, and added the ones for n=8,
    too.

I did not includes clocks with values for n that exist according to
the documentation, but are not used as suppliers for modules.
Of course the documentation may be incorrect or incomplete, and we may
need to add them later. As IDs are ABI and the list is append-only,
they must be added at the end, which could indeed lead to not all
clocks of the same group being located together.  From an ABI point
of view that is OK, but from a human-readability point of view it is
indeed suboptimal.

Before, we tended to add all clocks from the clock tables listed the
documentation upfront, ignoring clocks that are clearly internal-only.
Some of them turned out not to exist later.
Some new clocks had to be added when the documentation was updated.
Nothing new here, except that the list of clocks on R-Car X5H is an
order of magnitude longer.

Note that we don't use a linear array of clocks indexed by clock ID
in the R-Car X5H CPG driver (yet), so large holes of unused clocks do
not hurt (they do hurt in the SCMI driver ;-)

> not directly controllable. There's a risk of adding clocks that don't

FTR, the xDn clocks are not directly controllable; clocks like
R8A78000_CPG_MSO_SCP_MAIN are.  We know the latter exist, as they
are used.

> exist, or clocks that we won't need to reference from DT (because
> they're only used as parents of the MDLC-controlled module clock). Do

The direct parent of an MDLC-controlled module clock should be in DT.
Higher-up parents should not be needed iff the SCMI firmware exposed
and/or implements the proper clock hierarchy (which it does not at
the moment).  Still, they can be internal enum, starting after the last
DT clock, like we did in other R-Car clock drivers.

> you think that's an issue, could it cause ABI problems in the future ?

An ABI problem appears only when you refer in DT to a clock that does
not exist in hardware.  This should be caught by testing before the
DT user is added.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
