Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4821476CF6
	for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154012; cv=pass; b=JEfXUT5g1EyzLPd6E1+2b/ibkt6oliDJLyLK3DULIyYcjA97bbdslDy86OHnax++5Pg3h+dv81SDdUoaBboxG2hqgEPFb/7QoJX5lxLCUCux/izkthrjMtHcAtoXlwyzMTlg97njrLKzGz/pf01XrSpqPrHMdJNo6dBR6xw/ZUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154012; c=relaxed/simple;
	bh=X11PYpOG7j3MH77GVtbZHmuajB9XspHdb9qMykdxlog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLb9tCPnmpW/cmxRhj4nF7/r4r+Bj1Qn3r5RMfDYIKNl8fUahjYHvYcNkhx6Nw9XVXx3kfD8OuIYNQYIYjf4v4v45dYkT0ejaNlUgRw6UKCqjHNvji6dIKR3IKPWi7AndO5+a9+9aSMaWgZBjKTnnnxNHcd1PI9v1v825fdC6HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa/Gq4Ik; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa/Gq4Ik"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7ab11c26693so351670137.2
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 02:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790154002; cv=none;
        d=google.com; s=arc-20260327;
        b=kqWA6DLp2CgORAJVaEcjBXCcW5jSWXY4tMa6i1VgaZ3GNWGytXi4PaW+wCKTmg7qPc
         rUl23ujHljoBVblgALGxLgTrKJQJvPKCCxpA53EBcvh3egE6h/q62nedgUbXe3MK83CT
         8DSsS3fXXRMMJA3Ja0mlGIrvgQcO705Gri73+cbd/FkaLS7bt8d2aGOXnXYJG5NU1O5a
         g1eV4vpYdERLuLw7dF9Y/JsQq6CPlk0r5rkoOIQS8lmdF1VkQrHu4TD1Yyf/fvN13KOo
         gsRjKpsQehiq8GRKd6msEaD4I6CG9hweh522z4nSlOAC2sEtNit3PY87dyrX0RD6qOhf
         umWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SssPuySZ+ONqVnV0dgyJwUId1z/FwMaxOon4CCNT36I=;
        fh=jUitQP1ctLrZujMV3j5/S70CXv4S+OQZHCyLSZcYeH4=;
        b=XZQdzgWec8VDli5JKFoiexdUvMhISmyOM5RCOhwt3Rd751yTJae3ypJuX9yWV96JwQ
         jjy/xt3Yu0YVwyFroTX0Oi00QSIi2p3cMVcuH6hAv/0W1odu6AVLKUmYop+iQdr1MAQf
         UmyIFougx1UsXjPWIv1sQVTEQsVY4xuKot6IKGaAP0/Pj5My2IbzZ8Sawf5ZOTzhdPSy
         swqMnB9mLgGCF2w+/SRm1XetJybGMOHxvm6hO7u5ja8ve88cY+DLDdNPwvcV7J1aEmOa
         Jny3nSXk2x2ph2c62NwE1B543JCnSk/CREH/uRQo06LvQ22Jv7VOvpuQAbJ7cD+WDI4y
         +DKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790154002; x=1790758802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SssPuySZ+ONqVnV0dgyJwUId1z/FwMaxOon4CCNT36I=;
        b=Pa/Gq4IkWUbyHnRmf9pl+/rukjTd4pC1f6cG3HmiDBtGrMBqevPRgArLVOYMh6SvtK
         tXDcmKxQ4HU5w2KUXcVjTfcwtfafP1q9OVLGVNj5K8lFuSM65b3Ac0Z/DiZnCuczM2GK
         abQOgzDiAugRdKs+f5hQvk/8TusrC0DGggJdrs2eUEUsph1jXoR8DCJajjlBPZ332Xo0
         0iEOw8/HSCjK5cktZe3SiocgRndMcsyfEWsD4XwA9dpiIZXw5S1ls+v2hIgeq9F0XO7I
         d52JoRoOMz97j4CGTchnTvX7qQaT36ckwctdt37Itgqep7okQHerKRoLTWjH4g5RPl/C
         ySJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790154002; x=1790758802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SssPuySZ+ONqVnV0dgyJwUId1z/FwMaxOon4CCNT36I=;
        b=ocuu4rYLoM6J7ErcjJzpmhv2Q92z/pklB4ocOTsAZyiXCrI/2kllVTAyCFOjMC+bH3
         GwJ2pFiN9VRZB0i/OOsiaHfZje+NLSjIysj2xYCanbf+TxHrwu1frf1dqIDcgvaOGxvr
         GUbZ8xZUASGdFkAo/RwgZlRocJlsqzf2hrY9bai3T/BkiVcDKiInPhHUiW90kR/EVkXG
         yd6XXcu7EU7iJ49+mmAOzU29ymEgZ67G4RUg36VtymjZtnGPhzUqZuINWFGejI34+ppK
         UQ5ouuYeQ0RCjRn+V2+iFXlxhl7IDwH5iqAJIqhdiT+7b0d0sVYhZfNNtDNF97p030do
         txMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHmdGTlBjISrRzRQZ5I0NE5079saMzOtNStftj3AilJotjpwASh1VTnoN+1EVhRYuC/l8fx5TTWys=@vger.kernel.org
X-Gm-Message-State: AFuF++nzN8jCZtV5qm2Ov3ZcK8SCkhv6yfYV/MynUHEjdj/HSS0OtVLK
	qrDVTCKLw0ptn2zUuSHRJCe7MmJlk31Vp0iNcA1sLX9yZYShu6GAgMQ5B8/+Ci+2C1uFn0txCK1
	mQaGMeUJbVoEr4B1bClKazIIP3udzcrE=
X-Gm-Gg: AYBFou1g+NNuY0HHwHq2BoILGo30uta9LRsXHsDEEh6Fw74xHIdB2UQMf3vvBEu3nXW
	CKCulj6Vn1hOhHKvZKa1DxJd/EjlfVJ3yCudlnAhVPVuKZE2NBxyZqSDIWFrLLMnxprSF66fZUw
	/ayV8iEIOGuRJRYB+vSPLQ2/jv4xhCHsXw+lQ/KTi7ETmWKvwzkaqMVI3XSC2hwf5eXoQQ/g62O
	c+3IcSXMmnc/W294wt/7YHhrE9JP66xTqhn+eCP1gc1S7QLrA+OwHqbdKrCwxwEpYhMDclbWICm
	gW/bpp1aHcDRuxJoWAKstCSYYoPG3NDErqRJUAfg02nnTnITTPLT5DxXKW8p9XtMWbfNRDvL/TR
	UfDwldKTtr1wPgaP51YT8uBE6lme5kcYH+9DA9irRTlbkOZTHiaASiyx9Mjrs9Au0rmy0WMMtMD
	DK63Swv5036rX8beCP/UFDuAPu7MWA3namOz3YAjsrw/VP
X-Received: by 2002:a05:6102:e0f:b0:7a8:15b9:dd34 with SMTP id
 ada2fe7eead31-7ac1a8b4507mr2062674137.2.1790154001890; Wed, 23 Sep 2026
 02:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
 <20260804-h616-pwm-v8-v8-2-db37ab8624ae@gmail.com> <arFMta6PPwmzSk86@monoceros>
 <CADvTj4r1sFjPko7G5DwrPUw9x1tPzQspJhCUmHSMtrudn7SXEQ@mail.gmail.com>
 <33e760ca-2bb4-4f1d-a736-7e74a97e60c4@bootlin.com> <CADvTj4rBUNF6EaKXbsy5t1cS0iakpWVdpQ5sQF2qLS4YyHM2aQ@mail.gmail.com>
 <58145d8f-dd16-4cc2-b2ea-d475462241ab@bootlin.com> <CADvTj4oUpx7E2mrBgbZgUcFc6Mkt2Tn2mpwSBPdKk2MG6dmkDg@mail.gmail.com>
 <5331c1d8-4eef-45db-a53e-ba6bf08be208@bootlin.com>
In-Reply-To: <5331c1d8-4eef-45db-a53e-ba6bf08be208@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 23 Sep 2026 02:59:49 -0600
X-Gm-Features: AclHuK9lNu5pHzzh_ckX5_tWS7ag2EmM5QDSekVsdSXrl0hst3N8ifMZ42t3A4o
Message-ID: <CADvTj4oFPCgE9OCrd42gFC+bSL4+UTak0c8DUhikZ=uC8A38xw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] pwm: sun8i: Add H616 PWM support
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:52=E2=80=AFAM Richard GENOUD
<richard.genoud@bootlin.com> wrote:
>
> Le 23/09/2026 =C3=A0 10:01, James Hilliard a =C3=A9crit :
> > On Wed, Sep 23, 2026 at 1:16=E2=80=AFAM Richard GENOUD
> > <richard.genoud@bootlin.com> wrote:
> >>
> >> Le 22/09/2026 =C3=A0 17:46, James Hilliard a =C3=A9crit :
> >>> On Tue, Sep 22, 2026 at 9:13=E2=80=AFAM Richard GENOUD
> >>> <richard.genoud@bootlin.com> wrote:
> >>>>
> >>>> Le 22/09/2026 =C3=A0 02:27, James Hilliard a =C3=A9crit :
> >>>>> On Mon, Sep 21, 2026 at 10:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukl=
einek@kernel.org> wrote:
> >>>>>>
> >>>>>> On Tue, Aug 04, 2026 at 03:27:25PM -0600, James Hilliard wrote:
> >>>>>>> From: Richard Genoud <richard.genoud@bootlin.com>
> >>>>>>>
> >>>>>>> Add a driver for the Allwinner H616 PWM controller, supporting si=
x
> >>>>>>> channels. Each channel output can carry either a PWM waveform or =
a clock
> >>>>>>> from its bypass path.
> >>>>>>>
> >>>>>>> The channels are paired as 0/1, 2/3 and 4/5. Each pair shares a m=
ux, gate
> >>>>>>> and prescaler, while each channel has its own prescaler and bypas=
s.
> >>>>>>>
> >>>>>>> Register each shared pair mux, divider and gate with the Common C=
lock
> >>>>>>> Framework, and expose each channel bypass as a clock output. Prog=
ram the
> >>>>>>> channel-specific divider directly in the PWM path. Arbitrate each=
 output
> >>>>>>> when the PWM is requested or the bypass clock is prepared, and ho=
ld the
> >>>>>>> shared pair rate exclusively while either sibling output is activ=
e.
> >>>>>>>
> >>>>>>> CCF reference counts do not describe outputs left active by firmw=
are.
> >>>>>>> Before disabling a pair gate or changing its rate, also inspect t=
he
> >>>>>>> hardware channel-enable bits. Preserve inherited outputs through =
generic
> >>>>>>> unused-clock cleanup so declared consumers can claim them. At dri=
ver
> >>>>>>> sync_state(), stop channels which remain unowned and reconcile an=
 empty
> >>>>>>> shared pair gate through CCF. This prevents both premature shutdo=
wn of a
> >>>>>>> late-probing consumer and indefinite unclaimed outputs.
> >>>>>>>
> >>>>>>> The clock-provider interface is needed because pwm-clock cannot a=
ccurately
> >>>>>>> represent the bypass path. For example, pwm-clock represents 24 M=
Hz as an
> >>>>>>> integer 42 ns PWM period. The PWM waveform-rounding rules happen =
to select
> >>>>>>> the H616 bypass and produce 24 MHz for that request, but the pwm-=
clock API
> >>>>>>> does not require its advertised clock rate to equal the rounded h=
ardware
> >>>>>>> waveform.
> >>>>>>
> >>>>>> I don't understand the issue here. When you write pwm-clock, do yo=
u mean
> >>>>>> drivers/clk/clk-pwm.c or drivers/pwm/pwm-clk.c? (I guess the forme=
r.)
> >>>>>
> >>>>> Yes, drivers/clk/clk-pwm.c. You're right that the 42 ns period, 21 =
ns duty
> >>>>> request selects the 24 MHz bypass when that rate is available.
> >>>>>
> >>>>
> >>>> I've played a bit with the v9, and indeed the 24MHz bypass is select=
ed
> >>>> when the requested period in between 42ns and 49ns (23.8MHz and 20.4=
Mhz)
> >>>> So, for those periods, we only have a access to 0%, 50% and 100% dut=
y.
> >>>> And for the periods between 20ns to 41ns, the 100MHz clock is select=
ed
> >>>> without bypass:
> >>>> - 20ns->29ns: 2 period cycles, pwm prd=3D50MHz (so, 0% and 100% duty=
)
> >>>> - 30ns->39ns: 3 period cycles, pwm prd=3D33MHz (so, 0%, 50% and 100%=
 duty)
> >>>> - 40ns->41ns: 4 period cycles, pwm prd=3D25MHz (so, 0%, 33%, 66% and=
 100%
> >>>> duty)
> >>>> - 42ns->49ns: 24MHz bypass (so 0%, 50% and 100% duty)
> >>>> Then, the 100MHz clock is selected again:
> >>>> - 50ns->59ns: 5 period cycles, pwm prd=3D20MHz  (so, 0%, 25%, 50%, 7=
5 and
> >>>> 100% duty)
> >>>> and so on.
> >>>>
> >>>> It seems a little bit strange to have a 24MHz clock with only 3 duty
> >>>> steps available between 42ns and 49ns.
> >>>
> >>> Yes, I reproduce those three output levels with the v9 rounding helpe=
rs.
> >>> The 50% output uses bypass; constant low and high use cycle mode.
> >>>
> >>> However, removing bypass candidates alone doesn't make the driver cho=
ose
> >>> the 40 ns alternative. A single 24 MHz cycle still rounds to 42 ns an=
d
> >>> wins on period, leaving just constant low/high. The low resolution he=
re
> >>> is therefore not solely caused by considering bypass.
> >>>
> >>>> We have the same behavior at each bypass, for example at 12MHz (24MH=
z
> >>>> and /2 prescaler):
> >>>> for periods 84ns to 89ns, we have the 24MHz/2 bypass selected, with =
only
> >>>> 3 duty steps.
> >>>> (for 83ns, we have the 100MHz clock and 8 period cycles)
> >>>> same for 10667ns->10669ns (24MHz/256) =3D> 3 duty steps available
> >>>> whereas at 10666ns, we have 1066 duty steps available with the 100MH=
z clock.
> >>>
> >>> I don't reproduce the three-level limit in that case when the sibling
> >>> doesn't constrain the pair. Ordinary PWM at 24 MHz with 256 period ti=
cks
> >>> has the same rounded 10667 ns period and provides 257 duty levels,
> >>> including the two constant levels. For example, 10667/2667 ns and
> >>> 10667/8000 ns both select cycle mode and round exactly in integer ns.
> >> Indeed, my bad.
> >> At those steps, the bypass is not selected, the drivers switches to th=
e
> >> 24MHz clock. It's selected only between 42ns and 49ns
> >>
> >>>
> >>> Bypass can win a tie for a 50% request if the pair is already at 9375=
0 Hz,
> >>> but the mode and pair rate are reconsidered for the next duty request=
.
> >>> Was the sibling holding the pair rate in your test?
> >>>
> >>> Also, the short-period duty tables seem off by one: the period regist=
er
> >>> stores ticks minus one. Two 100 MHz ticks allow 0%, 50% and 100%; thr=
ee
> >>> allow 0%, 1/3, 2/3 and 100%.
> >> yes, so we have:
> >> - 20ns->29ns: 2 period cycles, pwm prd=3D50MHz (so, 0%, 50% and 100% d=
uty)
> >> - 30ns->39ns: 3 period cycles, pwm prd=3D33MHz (so, 0%, 33%, 66% and 1=
00%
> >> duty)
> >> - 40ns->41ns: 4 period cycles, pwm prd=3D25MHz (so, 0%, 25%, 50%, 75% =
and
> >> 100% duty)
> >> - 42ns->49ns: 24MHz bypass (so 0%, 50% and 100% duty)
> >> - 50ns->59ns: 5 period cycles, pwm prd=3D20MHz (so, 0%, 20%, 40%, 60%,=
 80%
> >> and 100% duty)
> >>
> >>>
> >>>> If the bypass is chosen over a non-bypassed alternative, then we can=
 get
> >>>> rid of the clk-provider and use pwm-clock instead, but we loose duty
> >>>> steps around each bypassed frequency.
> >>>
> >>> There is still the separate rate-reporting issue. If a sibling holds =
the
> >>> pair at 100 MHz, the 42/21 ns request becomes 40/20 ns, i.e. 25 MHz,
> >>> while pwm-clock continues to advertise its configured 24 MHz. Selecti=
ng
> >>> bypass when it is available doesn't remove that mismatch.
> >>>
> >>>> IMHO, the PWM driver has not enough informations to choose between t=
he
> >>>> bypass and maximizing the duty steps number. That's why I prefer mor=
e
> >>>> duty steps and adding a clock-provider (and also because when the by=
pass
> >>>> is enabled, there's no pulse-width modulation anymore, just a clock =
:))
> >>>>
> >>>> if we had the period, duty_cycle and the max duty steps required as
> >>>> input, we could choose, but that's not the case.
> >>>>
> >>>> So I guess that the real question here is:
> >>>> Is it better to have more duty steps, or to have a closer clock?
> >>>
> >>> The resolution tradeoff is real, but the waveform API currently speci=
fies
> >>> the ordering: choose the largest period not exceeding the request, th=
en
> >>> the largest compatible duty length not exceeding the request, then th=
e
> >>> offset. That's the ordering implemented in v9.
> >>>
> >> The ordering stated by pwm_round_waveform_might_sleep() documentation =
is
> >> period_length_ns, duty_length_ns and then duty_offset_ns, but what abo=
ut
> >> duty steps?
> >> It's not stated in there because it's not a user input, but still, it'=
s
> >> a quite important value for a pulse width *modulator*.
> >>
> >> My point here is that there's a choice between 2 implementations:
> >> - Consider the bypass as an emergency tool in order to get frequencies
> >> that are out of bound of the PWM logic (so that would mean only 100MHz=
)
> >> and in this case, we have more duty steps for the other periods, like =
a
> >> standard pulse width modulator
> >> - Or consider that the bypass is part of the PWM logic and don't bothe=
r
> >> looking at duty steps. In this case, it's used to get closer frequenci=
es
> >> to what is requested, and have only 0/50/100% duty for those case.
> >> (and for this driver, the only case is for the 42ns to 49ns periods)
> >>
> >> I'm more enclined to choose the 1st case, because a bypass bypasses th=
e
> >> PWM logic (!) and we can say that it's not part of the PWM and should
> >> only be used for the clk-provider part and to reach the 100MHz PWM
> >> frequency, but that's only my point of view.
> >
> > I agree that duty resolution matters. I think the remaining question is
> > which configurations we should expose to the waveform API, rather than
> > whether bypass itself is PWM.
> >
> > Restricting bypass alone would not give the higher-resolution
> > alternative. With the 24 MHz and 100 MHz parents and an unconstrained
> > pair, a single 24 MHz cycle still reports a 42 ns period and wins over
> > 40 ns. For example, a 42 ns period / 31 ns high-time request currently
> > becomes 42/21 ns; without bypass candidates it becomes 42/0 ns, not
> > 40/30 ns.
> No, because for a 42ns period, the PWM logic can't choose the 24MHz
> clock, it's out of bounds. The lowest achievable period with the 24MHz
> clock and no bybass is 84ns.
> So, the only remaining possibility without bypass is the 100MHz clock.

Yes, producing both a high and a low interval requires at least two
ticks, so the shortest non-constant waveform from 24 MHz has an
83.333 ns period, reported as 84 ns.

My 42/0 ns example was a constant-low output, not a toggling 24 MHz
waveform. I should have made that explicit. The manual documents
PWM_ENTIRE_CYCLE =3D 0 as one cycle, and the current rounding helper
includes that setting. For the 42/31 ns request, it calculates one
period tick and zero active ticks.

If we exclude one-tick cycle-mode candidates as well as the 24 MHz
bypass, I agree that the result becomes 40/30 ns using 100 MHz.
Removing the bypass candidates alone does not do that in the current
implementation.

>
> >
> > The same tradeoff occurs entirely in cycle mode: at 84 ns, two 24 MHz
> > ticks provide three duty levels, while eight 100 MHz ticks provide nine
> > levels at 80 ns.
> >
> > So achieving the resolution preference would also require restricting
> > ordinary cycle-mode candidates or changing the period-first selection
> > policy.
> >
> >>
> >> Regards,
> >> Richard.
> >>>>
> >>>> Regards,
> >>>> Richard
> >>>>
> >>>>>> If you do
> >>>>>>
> >>>>>>            compatible =3D "pwm-clock";
> >>>>>>            clock-frequency =3D <24000000>;
> >>>>>>            pwms =3D <&pwm0 42 ...>;
> >>>>>>
> >>>>>> that should give you a reliable match?!
> >>>>>>
> >>>>>>> Exposing the bypass through CCF provides an exact rate request,
> >>>>>>> conveys that duty-cycle and polarity control are not needed, and =
makes the
> >>>>>>> shared pair clock visible to CCF rate arbitration.
> >>>>>>
> >>>>>> Are you "just" suffering that clocks are programmed in Hz which PW=
Ms are
> >>>>>> programmed in ns and thus your losing precision on divisions?
> >>>>>
> >>>>> There is also the distinction between the advertised and resulting =
rate.
> >>>>> clk-pwm advertises its configured fixed frequency without checking =
the
> >>>>> rounded PWM frequency. If an active sibling holds the shared pair a=
t
> >>>>> 100 MHz, that same request rounds to 40 ns with 20 ns high time, i.=
e.
> >>>>> 25 MHz, while pwm-clock still reports 24 MHz.
> >>>>>
> >>>>> The direct provider reports the actual pair rate and exposes its sh=
ared
> >>>>> rate protection to CCF. CCF can still round a rate request, so this=
 is not
> >>>>> an unconditional exact-rate guarantee. I've clarified that in v9.
> >>>>>
> >>>>>>> Wait for the hardware period-update handshake before replacing PP=
R. Track
> >>>>>>> the active and newly programmed periods so normal updates use a t=
ight
> >>>>>>> timeout, while an unknown firmware update conservatively allows t=
he maximum
> >>>>>>> hardware period. Scale the sleep interval to keep the number of M=
MIO polls
> >>>>>>> bounded even for very long periods.
> >>>>>>>
> >>>>>>> Dead-zone mode is not representable by the PWM API. Reject it whi=
le either
> >>>>>>> output in the pair is active, but clear dormant dead-zone enable =
state when
> >>>>>>> both outputs are disabled so stale firmware configuration does no=
t
> >>>>>>> permanently prevent ordinary PWM use.
> >>>>>>>
> >>>>>>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> >>>>>>> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> >>>>>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >>>>>>> ---
> >>>>>>> Changes v7 -> v8:
> >>>>>>>      - clear the complete two-bit clock-source selector field
> >>>>>>>      - leave rate and period registers untouched when disabling a=
 channel
> >>>>>>>      - distinguish PWM-owned bypass signals from clock-owned bypa=
ss outputs
> >>>>>>>      - round waveforms over all parent, pair-divider, channel-div=
ider and bypass
> >>>>>>>        choices according to the PWM core ordering
> >>>>>>>      - encode constant levels without overflowing the 16-bit acti=
ve-cycle field
> >>>>>>>      - allocate clock topology state per device and use the fixed=
 parent map
> >>>>>>>        (reported by Sashiko)
> >>>>>>>      - use managed clock registrations for complete probe-error c=
leanup
> >>>>>>>        (reported by Sashiko and suggested by Philipp)
> >>>>>>>      - deassert reset before registering clocks and keep the rese=
t handle local
> >>>>>>>        (reported by Sashiko and suggested by Philipp)
> >>>>>>>      - arbitrate channel ownership in clock prepare/unprepare and=
 select bypass
> >>>>>>>        only while the clock output is enabled  (reported by Sashi=
ko)
> >>>>>>>      - roll back failed PWM requests and serialize channel releas=
e
> >>>>>>>        (reported by Sashiko)
> >>>>>>>      - protect the shared pair source while either sibling channe=
l is active
> >>>>>>>        (reported by Sashiko)
> >>>>>>>      - preserve the 65536-tick duty intermediate before polarity =
conversion
> >>>>>>>        (reported by Sashiko)
> >>>>>>>      - avoid replaying write-one control bits while changing chan=
nel settings
> >>>>>>>        (reported by Sashiko)
> >>>>>>>      - keep the hardware-waveform state within the PWM core stora=
ge limit
> >>>>>>>      - clarify that either co-packaged AC200 or AC300 PHY uses th=
e bypass clock
> >>>>>>>      - drop Tested-by tags after the clock implementation was rew=
orked
> >>>>>>>      - quantize inverted waveforms in hardware ticks and report t=
heir
> >>>>>>>        physical offset
> >>>>>>>      - force released channels off so stale waveforms cannot rest=
art with a
> >>>>>>>        sibling
> >>>>>>>      - track the active and pending cycle for the period-update h=
andshake and
> >>>>>>>        adapt the sleep interval to bound MMIO polling on long per=
iods
> >>>>>>>      - quiesce rate, polarity and bypass transitions before repro=
gramming the
> >>>>>>>        output
> >>>>>>>      - clear unsupported pulse mode when programming periodic wav=
eforms
> >>>>>>>      - preserve firmware-active outputs through generic unused-cl=
ock cleanup,
> >>>>>>>        stop any still-unclaimed channels at sync_state(), reconci=
le empty pair
> >>>>>>>        gates through CCF, and reject pair retuning while either o=
utput is
> >>>>>>>        active
> >>>>>>>      - hold pair-rate exclusivity only while an output is active
> >>>>>>>      - make pair-rate changes transactional and restore a quiesce=
d output on
> >>>>>>>        failure
> >>>>>>>      - clear dormant dead-zone state when both pair outputs are d=
isabled,
> >>>>>>>        while rejecting active dead-zone and pulse modes which the=
 PWM API
> >>>>>>>        cannot represent
> >>>>>>>      - correct the hardware topology to show the pair gate before=
 div_m
> >>>>>>>      - remove unused register definitions and simplify the fixed =
parent
> >>>>>>>        topology
> >>>>>>> ---
> >>>>>>>     drivers/pwm/Kconfig     |   12 +
> >>>>>>>     drivers/pwm/Makefile    |    1 +
> >>>>>>>     drivers/pwm/pwm-sun8i.c | 1542 ++++++++++++++++++++++++++++++=
+++++++++++++++++
> >>>>>>>     3 files changed, 1555 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >>>>>>> index e8886a9b64d9..e7fd2e66b1aa 100644
> >>>>>>> --- a/drivers/pwm/Kconfig
> >>>>>>> +++ b/drivers/pwm/Kconfig
> >>>>>>> @@ -748,6 +748,18 @@ config PWM_SUN4I
> >>>>>>>            To compile this driver as a module, choose M here: the=
 module
> >>>>>>>            will be called pwm-sun4i.
> >>>>>>>
> >>>>>>> +config PWM_SUN8I
> >>>>>>> +     tristate "Allwinner sun8i/sun50i PWM support"
> >>>>>>> +     depends on ARCH_SUNXI || COMPILE_TEST
> >>>>>>> +     depends on HAS_IOMEM && COMMON_CLK
> >>>>>>> +     help
> >>>>>>> +       PWM framework driver for Allwinner controllers whose chan=
nels share
> >>>>>>> +       paired source clocks. In addition to PWM operation, each =
channel's
> >>>>>>> +       hardware bypass path can be exported as a clock output.
> >>>>>>> +
> >>>>>>> +       To compile this driver as a module, choose M here: the mo=
dule
> >>>>>>> +       will be called pwm-sun8i.
> >>>>>>> +
> >>>>>>>     config PWM_SUNPLUS
> >>>>>>>          tristate "Sunplus PWM support"
> >>>>>>>          depends on ARCH_SUNPLUS || COMPILE_TEST
> >>>>>>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >>>>>>> index 5630a521a7cf..9c922b1fd0b4 100644
> >>>>>>> --- a/drivers/pwm/Makefile
> >>>>>>> +++ b/drivers/pwm/Makefile
> >>>>>>> @@ -68,6 +68,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-st=
m32.o
> >>>>>>>     obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >>>>>>>     obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >>>>>>>     obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> >>>>>>> +obj-$(CONFIG_PWM_SUN8I)              +=3D pwm-sun8i.o
> >>>>>>>     obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> >>>>>>>     obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >>>>>>>     obj-$(CONFIG_PWM_TH1520)     +=3D pwm_th1520.o
> >>>>>>> diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..5c3580a0924d
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/drivers/pwm/pwm-sun8i.c
> >>>>>>> @@ -0,0 +1,1542 @@
> >>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>>>> +/*
> >>>>>>> + * Driver for Allwinner sun8i Pulse Width Modulation Controller
> >>>>>>> + *
> >>>>>>> + * (C) Copyright 2025 Richard Genoud, Bootlin <richard.genoud@bo=
otlin.com>
> >>>>>>> + * (C) Copyright 2026 James Hilliard <james.hilliard1@gmail.com>
> >>>>>>> + *
> >>>>>>> + * Based on drivers/pwm/pwm-sun4i.c with Copyright:
> >>>>>>> + *
> >>>>>>> + * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@bootl=
in.com>
> >>>>>>> + *
> >>>>>>> + * Channels are paired (0/1, 2/3, 4/5). Each pair shares a clock=
 source and
> >>>>>>> + * first prescaler (div_m), while each channel has its own secon=
d prescaler
> >>>>>>> + * (div_k) and bypass path.
> >>>>>>> + *
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +#include <linux/bitfield.h>
> >>>>>>> +#include <linux/bits.h>
> >>>>>>> +#include <linux/clk.h>
> >>>>>>> +#include <linux/clk-provider.h>
> >>>>>>> +#include <linux/device.h>
> >>>>>>> +#include <linux/err.h>
> >>>>>>> +#include <linux/io.h>
> >>>>>>> +#include <linux/iopoll.h>
> >>>>>>> +#include <linux/limits.h>
> >>>>>>> +#include <linux/math64.h>
> >>>>>>> +#include <linux/module.h>
> >>>>>>> +#include <linux/notifier.h>
> >>>>>>> +#include <linux/of.h>
> >>>>>>> +#include <linux/platform_device.h>
> >>>>>>> +#include <linux/pwm.h>
> >>>>>>> +#include <linux/reset.h>
> >>>>>>> +#include <linux/slab.h>
> >>>>>>> +#include <linux/spinlock.h>
> >>>>>>> +#include <linux/time.h>
> >>>>>>> +
> >>>>>>> +/* PWMCC Pairs Clock Configuration Registers */
> >>>>>>> +#define SUN8I_PWM_PCCR(pair)         (0x20 + ((pair) * 0x4))
> >>>>>>> +#define SUN8I_PWM_PCCR_SRC_SHIFT     7
> >>>>>>> +#define SUN8I_PWM_PCCR_SRC_MASK              GENMASK(1, 0)
> >>>>>>> +#define SUN8I_PWM_PCCR_GATE_BIT              4
> >>>>>>> +#define SUN8I_PWM_PCCR_GATE          BIT(SUN8I_PWM_PCCR_GATE_BIT=
)
> >>>>>>> +#define SUN8I_PWM_PCCR_BYPASS_BIT(chan)      ((chan) % 2 + 5)
> >>>>>>> +#define SUN8I_PWM_PCCR_DIV_M_SHIFT   0
> >>>>>>> +#define SUN8I_PWM_PCCR_DIV_M_WIDTH   4
> >>>>>>> +
> >>>>>>> +/* PWM Enable Register */
> >>>>>>> +#define SUN8I_PWM_PER                        0x40
> >>>>>>> +#define SUN8I_PWM_ENABLE(chan)               BIT(chan)
> >>>>>>> +
> >>>>>>> +/* PWM Control Register */
> >>>>>>> +#define SUN8I_PWM_PCR(chan)          (0x60 + (chan) * 0x20)
> >>>>>>> +#define SUN8I_PWM_PCR_PRESCAL_K_MASK GENMASK(7, 0)
> >>>>>>> +#define SUN8I_PWM_PCR_ACTIVE_STATE   BIT(8)
> >>>>>>> +#define SUN8I_PWM_PCR_MODE           BIT(9)
> >>>>>>> +#define SUN8I_PWM_PCR_PULSE_START    BIT(10)
> >>>>>>> +#define SUN8I_PWM_PCR_PERIOD_READY   BIT(11) /* 0: ready, 1: bus=
y */
> >>>>>>> +
> >>>>>>> +/* PWM Period Register */
> >>>>>>> +#define SUN8I_PWM_PPR(chan)          (0x64 + (chan) * 0x20)
> >>>>>>> +#define SUN8I_PWM_PPR_PERIOD_MASK    GENMASK(31, 16)
> >>>>>>> +#define SUN8I_PWM_PPR_DUTY_MASK              GENMASK(15, 0)
> >>>>>>> +#define SUN8I_PWM_PPR_PERIOD_VALUE(reg)      (FIELD_GET(SUN8I_PW=
M_PPR_PERIOD_MASK, reg) + 1)
> >>>>>>> +#define SUN8I_PWM_PPR_DUTY_VALUE(reg)        FIELD_GET(SUN8I_PWM=
_PPR_DUTY_MASK, reg)
> >>>>>>> +#define SUN8I_PWM_PPR_PERIOD(prd)    FIELD_PREP(SUN8I_PWM_PPR_PE=
RIOD_MASK, (prd) - 1)
> >>>>>>> +#define SUN8I_PWM_PPR_DUTY(dty)              FIELD_PREP(SUN8I_PW=
M_PPR_DUTY_MASK, dty)
> >>>>>>> +#define SUN8I_PWM_PPR_PERIOD_MAX     (FIELD_MAX(SUN8I_PWM_PPR_PE=
RIOD_MASK) + 1)
> >>>>>>> +
> >>>>>>> +/* PWM pair dead-zone control registers. */
> >>>>>>> +#define SUN8I_PWM_PDZCR(pair)                (0x30 + ((pair) * 0=
x4))
> >>>>>>> +#define SUN8I_PWM_PDZCR_ENABLE               BIT(0)
> >>>>>>> +
> >>>>>>> +#define SUN8I_PWM_PERIOD_READY_MARGIN_US     50
> >>>>>>> +#define SUN8I_PWM_PERIOD_READY_MIN_POLL_US   10
> >>>>>>> +#define SUN8I_PWM_PERIOD_READY_MAX_POLL_US   10000
> >>>>>>> +#define SUN8I_PWM_PERIOD_READY_POLL_COUNT    1024
> >>>>>>> +
> >>>>>>> +#define SUN8I_PWM_PAIR_IDX(chan)     ((chan) >> 1)
> >>>>>>> +
> >>>>>>> +/*
> >>>>>>> + * Block diagram of the PWM clock controller:
> >>>>>>> + *
> >>>>>>> + *             _____      ______      ________
> >>>>>>> + * OSC24M --->|     |    |      |    |        |
> >>>>>>> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> SUN8I_PWM_=
clock_src_xy
> >>>>>>> + *            |_____|    |______|    |________|
> >>>>>>> + *                               ________
> >>>>>>> + *                              |        |
> >>>>>>> + *                           +->| /div_k |---> SUN8I_PWM_clock_x
> >>>>>>> + *                           |  |________|
> >>>>>>> + *                           |    ______
> >>>>>>> + *                           |   |      |
> >>>>>>> + *                           +-->| Gate |----> SUN8I_PWM_bypass_=
clock_x
> >>>>>>> + *                           |   |______|
> >>>>>>> + * SUN8I_PWM_clock_src_xy ---+   ________
> >>>>>>> + *                           |  |        |
> >>>>>>> + *                           +->| /div_k |---> SUN8I_PWM_clock_y
> >>>>>>> + *                           |  |________|
> >>>>>>> + *                           |    ______
> >>>>>>> + *                           |   |      |
> >>>>>>> + *                           +-->| Gate |----> SUN8I_PWM_bypass_=
clock_y
> >>>>>>> + *                               |______|
> >>>>>>> + *
> >>>>>>> + * NB: when the bypass is set, all the PWM logic is bypassed.
> >>>>>>> + * So, the duty cycle and polarity can't be modified (we just ha=
ve a clock).
> >>>>>>> + * The bypass in PWM mode is used to achieve a 1/2 relative duty=
 cycle with the
> >>>>>>> + * fastest clock.
> >>>>>>> + *
> >>>>>>> + * SUN8I_PWM_clock_x/y serve for the PWM purpose.
> >>>>>>> + * SUN8I_PWM_bypass_clock_x/y serve for the clock-provider purpo=
se.
> >>>>>>> + *
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +/* /div_m is a power-of-two divider limited to /256. */
> >>>>>>> +static const struct clk_div_table sun8i_pwm_div_m_table[] =3D {
> >>>>>>> +     { .val =3D 0, .div =3D 1 },
> >>>>>>> +     { .val =3D 1, .div =3D 2 },
> >>>>>>> +     { .val =3D 2, .div =3D 4 },
> >>>>>>> +     { .val =3D 3, .div =3D 8 },
> >>>>>>> +     { .val =3D 4, .div =3D 16 },
> >>>>>>> +     { .val =3D 5, .div =3D 32 },
> >>>>>>> +     { .val =3D 6, .div =3D 64 },
> >>>>>>> +     { .val =3D 7, .div =3D 128 },
> >>>>>>> +     { .val =3D 8, .div =3D 256 },
> >>>>>>> +     { /* sentinel */ }
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +enum sun8i_pwm_mode {
> >>>>>>> +     SUN8I_PWM_MODE_NONE,
> >>>>>>> +     SUN8I_PWM_MODE_PWM,
> >>>>>>> +     SUN8I_PWM_MODE_CLK,
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_data {
> >>>>>>> +     unsigned int npwm;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_chip;
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_pair {
> >>>>>>> +     struct clk_mux mux;
> >>>>>>> +     struct clk_hw gate_hw;
> >>>>>>> +     struct clk_divider divider;
> >>>>>>> +     struct clk_hw *hw;
> >>>>>>> +     struct notifier_block rate_nb;
> >>>>>>> +     struct sun8i_pwm_chip *chip;
> >>>>>>> +     unsigned int index;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_bypass {
> >>>>>>> +     struct clk_hw hw;
> >>>>>>> +     struct sun8i_pwm_chip *chip;
> >>>>>>> +     unsigned int index;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_channel {
> >>>>>>> +     struct sun8i_pwm_bypass bypass;
> >>>>>>> +     struct clk *pair_clk;
> >>>>>>> +     enum sun8i_pwm_mode mode;
> >>>>>>> +     u64 pending_period_ns;
> >>>>>>> +     bool rate_exclusive;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_chip {
> >>>>>>> +     struct clk_hw_onecell_data *hw_data;
> >>>>>>> +     struct sun8i_pwm_pair *pairs;
> >>>>>>> +     struct sun8i_pwm_channel *channels;
> >>>>>>> +     struct clk *bus_clk;
> >>>>>>> +     void __iomem *base;
> >>>>>>> +     const struct sun8i_pwm_data *data;
> >>>>>>> +     /* Protects shared registers and channel ownership. */
> >>>>>>> +     spinlock_t lock;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_waveform {
> >>>>>>> +     u32 duty_ticks;
> >>>>>>> +     u32 period_ticks;
> >>>>>>> +     u32 pair_rate;
> >>>>>>> +     u16 div_k;
> >>>>>>> +     u8 enabled:1;
> >>>>>>> +     u8 active_state:1;
> >>>>>>> +     u8 bypass_en:1;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +static inline struct sun8i_pwm_chip *sun8i_pwm_from_chip(const s=
truct pwm_chip *chip)
> >>>>>>> +{
> >>>>>>> +     return pwmchip_get_drvdata(chip);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *sun8i_c=
hip,
> >>>>>>> +                               unsigned long offset)
> >>>>>>> +{
> >>>>>>> +     return readl(sun8i_chip->base + offset);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *sun8i=
_chip,
> >>>>>>> +                                 u32 val, unsigned long offset)
> >>>>>>> +{
> >>>>>>> +     writel(val, sun8i_chip->base + offset);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void sun8i_pwm_set_bypass_locked(struct sun8i_pwm_chip *s=
un8i_chip,
> >>>>>>> +                                     unsigned int idx, bool enab=
le)
> >>>>>>> +{
> >>>>>>> +     unsigned long reg_offset;
> >>>>>>> +     u32 val;
> >>>>>>> +
> >>>>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>>>> +
> >>>>>>> +     reg_offset =3D SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(idx));
> >>>>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, reg_offset);
> >>>>>>> +     if (enable)
> >>>>>>> +             val |=3D BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> >>>>>>> +     else
> >>>>>>> +             val &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> >>>>>>> +
> >>>>>>> +     sun8i_pwm_writel(sun8i_chip, val, reg_offset);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void sun8i_pwm_set_enabled_locked(struct sun8i_pwm_chip *=
sun8i_chip,
> >>>>>>> +                                      unsigned int idx, bool ena=
ble)
> >>>>>>> +{
> >>>>>>> +     u32 val;
> >>>>>>> +
> >>>>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>>>> +
> >>>>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     if (enable)
> >>>>>>> +             val |=3D SUN8I_PWM_ENABLE(idx);
> >>>>>>> +     else
> >>>>>>> +             val &=3D ~SUN8I_PWM_ENABLE(idx);
> >>>>>>> +     sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PER);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static bool
> >>>>>>> +sun8i_pwm_channel_is_enabled_locked(struct sun8i_pwm_chip *sun8i=
_chip,
> >>>>>>> +                                 unsigned int idx)
> >>>>>>> +{
> >>>>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(idx);
> >>>>>>> +     u32 pccr, per;
> >>>>>>> +
> >>>>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>>>> +
> >>>>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +
> >>>>>>> +     return (pccr & SUN8I_PWM_PCCR_GATE) &&
> >>>>>>> +            (per & SUN8I_PWM_ENABLE(idx));
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static u32 sun8i_pwm_pair_enable_mask(struct sun8i_pwm_chip *sun=
8i_chip,
> >>>>>>> +                                   unsigned int pair)
> >>>>>>> +{
> >>>>>>> +     unsigned int first =3D pair * 2;
> >>>>>>> +     u32 mask =3D SUN8I_PWM_ENABLE(first);
> >>>>>>> +
> >>>>>>> +     if (first + 1 < sun8i_chip->data->npwm)
> >>>>>>> +             mask |=3D SUN8I_PWM_ENABLE(first + 1);
> >>>>>>> +
> >>>>>>> +     return mask;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static u32
> >>>>>>> +sun8i_pwm_pair_owner_mask_locked(struct sun8i_pwm_chip *sun8i_ch=
ip,
> >>>>>>> +                              unsigned int pair)
> >>>>>>> +{
> >>>>>>> +     unsigned int first =3D pair * 2;
> >>>>>>> +     u32 mask =3D 0;
> >>>>>>> +
> >>>>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>>>> +
> >>>>>>> +     if (sun8i_chip->channels[first].mode !=3D SUN8I_PWM_MODE_NO=
NE)
> >>>>>>> +             mask |=3D SUN8I_PWM_ENABLE(first);
> >>>>>>> +     if (first + 1 < sun8i_chip->data->npwm &&
> >>>>>>> +         sun8i_chip->channels[first + 1].mode !=3D SUN8I_PWM_MOD=
E_NONE)
> >>>>>>> +             mask |=3D SUN8I_PWM_ENABLE(first + 1);
> >>>>>>> +
> >>>>>>> +     return mask;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline struct sun8i_pwm_pair *
> >>>>>>> +sun8i_pwm_pair_from_gate_hw(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     return container_of(hw, struct sun8i_pwm_pair, gate_hw);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_pair_gate_enable(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw=
(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     u32 pccr;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair->i=
ndex));
> >>>>>>> +     pccr |=3D SUN8I_PWM_PCCR_GATE;
> >>>>>>> +     sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pair->ind=
ex));
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void sun8i_pwm_pair_gate_disable(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw=
(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>>>> +     unsigned long reg =3D SUN8I_PWM_PCCR(pair->index);
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     u32 pccr, per;
> >>>>>>> +
> >>>>>>> +     /* CCF counts do not include outputs awaiting firmware-stat=
e handoff. */
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     if (!(per & sun8i_pwm_pair_enable_mask(sun8i_chip, pair->in=
dex))) {
> >>>>>>> +             pccr =3D sun8i_pwm_readl(sun8i_chip, reg);
> >>>>>>> +             pccr &=3D ~SUN8I_PWM_PCCR_GATE;
> >>>>>>> +             sun8i_pwm_writel(sun8i_chip, pccr, reg);
> >>>>>>> +     }
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_pair_gate_is_enabled(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw=
(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>>>> +     unsigned long reg =3D SUN8I_PWM_PCCR(pair->index);
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     bool enabled;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     enabled =3D sun8i_pwm_readl(sun8i_chip, reg) & SUN8I_PWM_PC=
CR_GATE;
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return enabled;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static const struct clk_ops sun8i_pwm_pair_gate_ops =3D {
> >>>>>>> +     .enable =3D sun8i_pwm_pair_gate_enable,
> >>>>>>> +     .disable =3D sun8i_pwm_pair_gate_disable,
> >>>>>>> +     .is_enabled =3D sun8i_pwm_pair_gate_is_enabled,
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_pair_rate_notifier(struct notifier_block *n=
b,
> >>>>>>> +                                     unsigned long event, void *=
data)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_pair *pair =3D
> >>>>>>> +             container_of(nb, struct sun8i_pwm_pair, rate_nb);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     bool active;
> >>>>>>> +
> >>>>>>> +     if (event !=3D PRE_RATE_CHANGE)
> >>>>>>> +             return NOTIFY_DONE;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     active =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER) &
> >>>>>>> +              sun8i_pwm_pair_enable_mask(sun8i_chip, pair->index=
);
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return active ? NOTIFY_BAD : NOTIFY_OK;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline struct sun8i_pwm_bypass *
> >>>>>>> +sun8i_pwm_bypass_from_hw(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     return container_of(hw, struct sun8i_pwm_bypass, hw);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_bypass_prepare(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_h=
w(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[by=
pass->index];
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     int ret =3D 0;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     if (chan->mode !=3D SUN8I_PWM_MODE_NONE)
> >>>>>>> +             ret =3D -EBUSY;
> >>>>>>> +     else
> >>>>>>> +             chan->mode =3D SUN8I_PWM_MODE_CLK;
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return ret;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void sun8i_pwm_bypass_unprepare(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_h=
w(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[by=
pass->index];
> >>>>>>> +     unsigned long flags;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK))
> >>>>>>> +             goto out_unlock;
> >>>>>>> +
> >>>>>>> +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> >>>>>>> +
> >>>>>>> +out_unlock:
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_bypass_enable(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_h=
w(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[by=
pass->index];
> >>>>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(bypass->index);
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     u32 pccr, per;
> >>>>>>> +     int ret =3D 0;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK)) {
> >>>>>>> +             ret =3D -EBUSY;
> >>>>>>> +             goto out_unlock;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     if (!(pccr & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(bypass->index)))=
 ||
> >>>>>>> +         !(per & SUN8I_PWM_ENABLE(bypass->index))) {
> >>>>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->in=
dex, false);
> >>>>>>> +             sun8i_pwm_set_bypass_locked(sun8i_chip, bypass->ind=
ex, true);
> >>>>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->in=
dex, true);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +out_unlock:
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return ret;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void sun8i_pwm_bypass_disable(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_h=
w(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[by=
pass->index];
> >>>>>>> +     unsigned long flags;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK))
> >>>>>>> +             goto out_unlock;
> >>>>>>> +
> >>>>>>> +     sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->index, fal=
se);
> >>>>>>> +     sun8i_pwm_set_bypass_locked(sun8i_chip, bypass->index, fals=
e);
> >>>>>>> +
> >>>>>>> +out_unlock:
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void sun8i_pwm_bypass_disable_unused(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     /* Defer inherited-output cleanup to sun8i_pwm_sync_state()=
. */
> >>>>>>> +}
> >>>>>>
> >>>>>> I would expect that you can drop this empty callback?!
> >>>>>
> >>>>> Removed in v9, with CLK_IGNORE_UNUSED replacing it. Simply removing=
 the
> >>>>> callback would make CCF fall back to .disable(). The flag expresses=
 the
> >>>>> intent to preserve unclaimed firmware outputs through unused-clock
> >>>>> cleanup; normal consumer disable still turns the output off.
> >>>>>
> >>>>>>
> >>>>>>> +static int sun8i_pwm_bypass_is_enabled(struct clk_hw *hw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_h=
w(hw);
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(bypass->index);
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     bool enabled;
> >>>>>>> +     u32 val;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>>>> +     enabled =3D (val & SUN8I_PWM_PCCR_GATE) &&
> >>>>>>> +               (val & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(bypass->inde=
x)));
> >>>>>>> +
> >>>>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     enabled =3D enabled && (val & SUN8I_PWM_ENABLE(bypass->inde=
x));
> >>>>>>> +
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return enabled;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static unsigned long sun8i_pwm_bypass_recalc_rate(struct clk_hw =
*hw,
> >>>>>>> +                                               unsigned long par=
ent_rate)
> >>>>>>> +{
> >>>>>>> +     return parent_rate;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static const struct clk_ops sun8i_pwm_bypass_ops =3D {
> >>>>>>> +     .prepare =3D sun8i_pwm_bypass_prepare,
> >>>>>>> +     .unprepare =3D sun8i_pwm_bypass_unprepare,
> >>>>>>> +     .enable =3D sun8i_pwm_bypass_enable,
> >>>>>>> +     .disable =3D sun8i_pwm_bypass_disable,
> >>>>>>> +     .disable_unused =3D sun8i_pwm_bypass_disable_unused,
> >>>>>>> +     .is_enabled =3D sun8i_pwm_bypass_is_enabled,
> >>>>>>> +     .recalc_rate =3D sun8i_pwm_bypass_recalc_rate,
> >>>>>>> +};
> >>>>>>
> >>>>>> I have problems grokking how the clk and pwm frameworks interact h=
ere. I
> >>>>>> think that would be easier to understand if you split this patch i=
nto
> >>>>>> a basic pwm driver and in a 2nd patch add the clk stuff. Maybe als=
o
> >>>>>> split out the bypass stuff?
> >>>>>
> >>>>> V9 separates PWM support in patch 2 from the exported bypass clocks=
 and
> >>>>> PWM/clock ownership arbitration in patch 3.
> >>>>>
> >>>>> PWM request/free and clock prepare/unprepare arbitrate ownership of=
 the
> >>>>> physical output, so the two interfaces cannot own it simultaneously=
.
> >>>>>
> >>>>> The internal CCF pair clocks remain in patch 2, so both patches use=
 the
> >>>>> same implementation of the shared mux, divider and gate. Hardware b=
ypass
> >>>>> rounding also stays there: it is part of PWM waveform generation an=
d
> >>>>> inherited-state readback, independently of exporting a clock provid=
er
> >>>>>
> >>>>>>> +static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_d=
evice *pwm)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(c=
hip);
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pw=
m->hwpwm];
> >>>>>>> +     unsigned int idx =3D pwm->hwpwm;
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     bool was_enabled =3D false;
> >>>>>>> +     int ret;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     if (chan->mode !=3D SUN8I_PWM_MODE_NONE) {
> >>>>>>> +             ret =3D -EBUSY;
> >>>>>>> +     } else {
> >>>>>>> +             was_enabled =3D
> >>>>>>> +                     sun8i_pwm_channel_is_enabled_locked(sun8i_c=
hip, idx);
> >>>>>>> +             chan->mode =3D SUN8I_PWM_MODE_PWM;
> >>>>>>> +             ret =3D 0;
> >>>>>>> +     }
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +     if (ret)
> >>>>>>> +             return ret;
> >>>>>>
> >>>>>> With scoped_guard() this can be written in a nicer way.
> >>>>>
> >>>>> Converted to guard()/scoped_guard() in v9.
> >>>>>
> >>>>>>> +     if (was_enabled) {
> >>>>>>> +             ret =3D clk_rate_exclusive_get(chan->pair_clk);
> >>>>>>> +             if (ret)
> >>>>>>> +                     goto err_release_channel;
> >>>>>>> +             WRITE_ONCE(chan->rate_exclusive, true);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     ret =3D clk_prepare_enable(chan->pair_clk);
> >>>>>>> +     if (ret) {
> >>>>>>> +             if (READ_ONCE(chan->rate_exclusive)) {
> >>>>>>> +                     clk_rate_exclusive_put(chan->pair_clk);
> >>>>>>> +                     WRITE_ONCE(chan->rate_exclusive, false);
> >>>>>>> +             }
> >>>>>>> +             goto err_release_channel;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +
> >>>>>>> +err_release_channel:
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return ret;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(c=
hip);
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pw=
m->hwpwm];
> >>>>>>> +     unsigned long flags;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_PWM)) {
> >>>>>>
> >>>>>> WARN_ON is usually frowned upon, see e.g.
> >>>>>> https://lore.kernel.org/all/2026091953-cherub-empty-ef35@gregkh/.
> >>>>>
> >>>>> Removed the ownership WARN_ON_ONCE() calls.
> >>>>>
> >>>>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +             return;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, false)=
;
> >>>>>>> +     sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false);
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     if (READ_ONCE(chan->rate_exclusive)) {
> >>>>>>
> >>>>>> given this isn't performance critical (is it?) and we have a lock
> >>>>>> anyhow, I'd prefer to have chan->rate_exclusive protected by that =
lock,
> >>>>>> too, instead of mixing different atomics here.
> >>>>>
> >>>>> All accesses to rate_exclusive now use the shared register/ownershi=
p
> >>>>> lock. The CCF operations stay outside that spinlock because they ta=
ke the
> >>>>> prepare mutex and can call back into the driver.
> >>>>>
> >>>>>>> +             clk_rate_exclusive_put(chan->pair_clk);
> >>>>>>> +             WRITE_ONCE(chan->rate_exclusive, false);
> >>>>>>> +     }
> >>>>>>> +     clk_disable_unprepare(chan->pair_clk);
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
> >>>>>>> +                                struct pwm_device *pwm,
> >>>>>>> +                                void *_wfhw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(c=
hip);
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pw=
m->hwpwm];
> >>>>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(pwm->hwpwm);
> >>>>>>> +     unsigned long flags, pair_rate;
> >>>>>>> +     u32 pccr, pcr, pdzcr, per, ppr;
> >>>>>>> +
> >>>>>>> +     pair_rate =3D clk_get_rate(chan->pair_clk);
> >>>>>>> +     if (pair_rate > U32_MAX)
> >>>>>>> +             return -ERANGE;
> >>>>>>
> >>>>>> That should not happen. You lock the rate in .request(). So please=
 check
> >>>>>> the rate already there and return an error code.
> >>>>>
> >>>>> The rate is only protected while the PWM is active, not for its ent=
ire
> >>>>> requested lifetime. A requested but disabled PWM must still allow i=
ts
> >>>>> sibling to change the pair rate. Also, debugfs reads hardware state=
 for
> >>>>> channels which have not been requested.
> >>>>>
> >>>>> I therefore kept the checks where the rate is used rather than movi=
ng
> >>>>> them solely to .request().
> >>>>>
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpw=
m));
> >>>>>>> +     ppr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpw=
m));
> >>>>>>> +     pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair)=
);
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     *wfhw =3D (struct sun8i_pwm_waveform) {
> >>>>>>> +             .enabled =3D !!(pccr & SUN8I_PWM_PCCR_GATE) &&
> >>>>>>> +                        !!(per & SUN8I_PWM_ENABLE(pwm->hwpwm)),
> >>>>>>> +             .bypass_en =3D !!(pccr &
> >>>>>>> +                              BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pwm-=
>hwpwm))),
> >>>>>>> +             .active_state =3D !!(pcr & SUN8I_PWM_PCR_ACTIVE_STA=
TE),
> >>>>>>> +             .duty_ticks =3D SUN8I_PWM_PPR_DUTY_VALUE(ppr),
> >>>>>>> +             .period_ticks =3D SUN8I_PWM_PPR_PERIOD_VALUE(ppr),
> >>>>>>> +             .pair_rate =3D pair_rate,
> >>>>>>> +             .div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, =
pcr) + 1,
> >>>>>>> +     };
> >>>>>>> +
> >>>>>>> +     if (wfhw->enabled && !wfhw->bypass_en &&
> >>>>>>> +         (pdzcr & SUN8I_PWM_PDZCR_ENABLE))
> >>>>>>> +             return -EOPNOTSUPP;
> >>>>>>> +     if (wfhw->enabled && !wfhw->bypass_en &&
> >>>>>>> +         (pcr & SUN8I_PWM_PCR_MODE))
> >>>>>>> +             return -EOPNOTSUPP;
> >>>>>>
> >>>>>> These need at least a comment.
> >>>>>
> >>>>> Added a comment explaining that the waveform API cannot represent p=
ulse
> >>>>> mode or coupled dead-zone operation, and combined the rejection che=
cks.
> >>>>>
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static u64 sun8i_pwm_ticks_to_ns(u32 ticks, u16 div_k, u32 pair_=
rate)
> >>>>>>> +{
> >>>>>>> +     return DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)ticks * div_k,
> >>>>>>> +                             pair_rate);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void
> >>>>>>> +sun8i_pwm_waveform_to_ns(const struct sun8i_pwm_waveform *wfhw,
> >>>>>>> +                      struct pwm_waveform *wf)
> >>>>>>> +{
> >>>>>>> +     u32 pair_rate =3D wfhw->pair_rate;
> >>>>>>> +     u16 div_k =3D wfhw->div_k;
> >>>>>>> +
> >>>>>>> +     wf->duty_offset_ns =3D 0;
> >>>>>>> +
> >>>>>>> +     if (!wfhw->enabled || !pair_rate) {
> >>>>>>> +             wf->period_length_ns =3D 0;
> >>>>>>> +             wf->duty_length_ns =3D 0;
> >>>>>>> +             return;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (wfhw->bypass_en) {
> >>>>>>> +             wf->period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_=
SEC,
> >>>>>>> +                                                     pair_rate);
> >>>>>>> +             wf->duty_length_ns =3D
> >>>>>>> +                     DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> >>>>>>> +                                      2ULL * pair_rate);
> >>>>>>> +     } else {
> >>>>>>> +             wf->period_length_ns =3D sun8i_pwm_ticks_to_ns(wfhw=
->period_ticks,
> >>>>>>> +                                                          div_k,=
 pair_rate);
> >>>>>>> +             if (wfhw->active_state) {
> >>>>>>> +                     u32 duty_ticks =3D min(wfhw->duty_ticks,
> >>>>>>> +                                          wfhw->period_ticks);
> >>>>>>> +
> >>>>>>> +                     wf->duty_length_ns =3D
> >>>>>>> +                             sun8i_pwm_ticks_to_ns(duty_ticks, d=
iv_k, pair_rate);
> >>>>>>> +             } else if (!wfhw->duty_ticks) {
> >>>>>>> +                     wf->duty_length_ns =3D wf->period_length_ns=
;
> >>>>>>> +             } else if (wfhw->duty_ticks >=3D wfhw->period_ticks=
) {
> >>>>>>> +                     wf->duty_length_ns =3D 0;
> >>>>>>> +             } else {
> >>>>>>> +                     u32 low_ticks =3D wfhw->duty_ticks;
> >>>>>>> +                     u32 high_ticks =3D wfhw->period_ticks - wfh=
w->duty_ticks;
> >>>>>>> +
> >>>>>>> +                     wf->duty_length_ns =3D
> >>>>>>> +                             sun8i_pwm_ticks_to_ns(high_ticks, d=
iv_k, pair_rate);
> >>>>>>> +                     wf->duty_offset_ns =3D
> >>>>>>> +                             sun8i_pwm_ticks_to_ns(low_ticks, di=
v_k, pair_rate);
> >>>>>>> +             }
> >>>>>>> +     }
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_round_waveform_fromhw(struct pwm_chip *chip=
,
> >>>>>>> +                                        struct pwm_device *pwm,
> >>>>>>> +                                        const void *_wfhw,
> >>>>>>> +                                        struct pwm_waveform *wf)
> >>>>>>> +{
> >>>>>>> +     const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>>>> +
> >>>>>>> +     sun8i_pwm_waveform_to_ns(wfhw, wf);
> >>>>>>
> >>>>>> I suggest to rename that function to __sun8i_pwm_round_waveform_fr=
omhw()
> >>>>>> or similar to make the relation between the two functions obvious.
> >>>>>
> >>>>> Renamed to __sun8i_pwm_round_waveform_fromhw().
> >>>>>
> >>>>>>> +     dev_dbg(pwmchip_parent(chip),
> >>>>>>> +             "pwm#%u: pair-rate=3D%u, div-k=3D%u, period=3D%u, d=
uty=3D%u, bypass=3D%u, active-high=3D%u -> %llu/%llu [+%llu]\n",
> >>>>>>> +             pwm->hwpwm, wfhw->pair_rate, wfhw->div_k,
> >>>>>>> +             wfhw->period_ticks, wfhw->duty_ticks, wfhw->bypass_=
en,
> >>>>>>> +             wfhw->active_state,
> >>>>>>> +             wf->duty_length_ns, wf->period_length_ns,
> >>>>>>> +             wf->duty_offset_ns);
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static bool
> >>>>>>> +sun8i_pwm_pair_rate_constrained(struct sun8i_pwm_chip *sun8i_chi=
p,
> >>>>>>> +                             unsigned int idx)
> >>>>>>> +{
> >>>>>>> +     unsigned int sibling =3D idx ^ 1;
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     bool constrained;
> >>>>>>> +
> >>>>>>> +     if (sibling >=3D sun8i_chip->data->npwm)
> >>>>>>> +             return false;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     constrained =3D sun8i_chip->channels[sibling].mode =3D=3D
> >>>>>>> +                     SUN8I_PWM_MODE_CLK ||
> >>>>>>> +                   READ_ONCE(sun8i_chip->channels[sibling].rate_=
exclusive) ||
> >>>>>>> +                   sun8i_pwm_channel_is_enabled_locked(sun8i_chi=
p,
> >>>>>>> +                                                       sibling);
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return constrained;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_clear_idle_deadzone(struct sun8i_pwm_chip *=
sun8i_chip,
> >>>>>>> +                                      unsigned int idx)
> >>>>>>> +{
> >>>>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(idx);
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     u32 pdzcr, per;
> >>>>>>> +     int ret =3D 0;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair)=
);
> >>>>>>> +     if (!(pdzcr & SUN8I_PWM_PDZCR_ENABLE))
> >>>>>>> +             goto out_unlock;
> >>>>>>> +
> >>>>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     if (per & sun8i_pwm_pair_enable_mask(sun8i_chip, pair)) {
> >>>>>>> +             ret =3D -EOPNOTSUPP;
> >>>>>>> +             goto out_unlock;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     pdzcr &=3D ~SUN8I_PWM_PDZCR_ENABLE;
> >>>>>>> +     sun8i_pwm_writel(sun8i_chip, pdzcr, SUN8I_PWM_PDZCR(pair));
> >>>>>>> +
> >>>>>>> +out_unlock:
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return ret;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static u64 sun8i_pwm_max_period_ns(struct sun8i_pwm_chip *sun8i_=
chip,
> >>>>>>> +                                unsigned int idx)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[id=
x];
> >>>>>>> +     unsigned long flags, pair_rate;
> >>>>>>> +     u32 pcr;
> >>>>>>> +     u16 div_k;
> >>>>>>> +
> >>>>>>> +     pair_rate =3D clk_get_rate(chan->pair_clk);
> >>>>>>> +     if (!pair_rate || pair_rate > U32_MAX)
> >>>>>>> +             return 0;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(idx));
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +     div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pcr) + 1;
> >>>>>>> +
> >>>>>>> +     return sun8i_pwm_ticks_to_ns(SUN8I_PWM_PPR_PERIOD_MAX, div_=
k,
> >>>>>>> +                                  pair_rate);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_wait_period_ready(struct sun8i_pwm_chip *su=
n8i_chip,
> >>>>>>> +                                    unsigned int idx, u64 *timeo=
ut_us)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[id=
x];
> >>>>>>> +     unsigned long poll_us;
> >>>>>>> +     u64 period_ns;
> >>>>>>> +     u32 val;
> >>>>>>> +     int ret;
> >>>>>>> +
> >>>>>>> +     /* PPR contains the pending value, not necessarily the acti=
ve period. */
> >>>>>>> +     period_ns =3D chan->pending_period_ns;
> >>>>>>> +     if (!period_ns)
> >>>>>>> +             period_ns =3D sun8i_pwm_max_period_ns(sun8i_chip, i=
dx);
> >>>>>>> +     *timeout_us =3D DIV_ROUND_UP_ULL(period_ns, NSEC_PER_USEC) =
+
> >>>>>>> +                   SUN8I_PWM_PERIOD_READY_MARGIN_US;
> >>>>>>> +     poll_us =3D clamp_t(u64,
> >>>>>>> +                       DIV_ROUND_UP_ULL(*timeout_us,
> >>>>>>> +                                        SUN8I_PWM_PERIOD_READY_P=
OLL_COUNT),
> >>>>>>> +                       SUN8I_PWM_PERIOD_READY_MIN_POLL_US,
> >>>>>>> +                       SUN8I_PWM_PERIOD_READY_MAX_POLL_US);
> >>>>>>> +
> >>>>>>> +     ret =3D readl_poll_timeout(sun8i_chip->base + SUN8I_PWM_PCR=
(idx), val,
> >>>>>>> +                              !(val & SUN8I_PWM_PCR_PERIOD_READY=
), poll_us,
> >>>>>>> +                              *timeout_us);
> >>>>>>> +     if (!ret)
> >>>>>>> +             chan->pending_period_ns =3D 0;
> >>>>>>> +
> >>>>>>> +     return ret;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_write_waveform(struct pwm_chip *chip,
> >>>>>>> +                                 struct pwm_device *pwm, const v=
oid *_wfhw)
> >>>>>>> +{
> >>>>>>> +     const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(c=
hip);
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pw=
m->hwpwm];
> >>>>>>> +     struct device *dev =3D pwmchip_parent(chip);
> >>>>>>> +     unsigned long bus_rate, current_rate, restored_rate;
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     u64 new_ns, old_ns, timeout_us;
> >>>>>>> +     bool acquired_exclusive =3D false;
> >>>>>>> +     bool can_restore_enable =3D true;
> >>>>>>> +     bool current_bypass, needs_quiesce, was_enabled;
> >>>>>>> +     u16 current_div_k;
> >>>>>>> +     u32 old_ticks, pcr, ppr, val;
> >>>>>>> +     int restore_ret, ret;
> >>>>>>> +
> >>>>>>> +     if (!wfhw->enabled) {
> >>>>>>> +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm=
, false);
> >>>>>>> +             sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm,=
 false);
> >>>>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +             if (READ_ONCE(chan->rate_exclusive)) {
> >>>>>>> +                     clk_rate_exclusive_put(chan->pair_clk);
> >>>>>>> +                     WRITE_ONCE(chan->rate_exclusive, false);
> >>>>>>> +             }
> >>>>>>> +
> >>>>>>> +             return 0;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (!wfhw->pair_rate ||
> >>>>>>> +         (!wfhw->bypass_en &&
> >>>>>>> +          (!wfhw->div_k || wfhw->div_k > 256 ||
> >>>>>>> +           !wfhw->period_ticks ||
> >>>>>>> +           wfhw->period_ticks > SUN8I_PWM_PPR_PERIOD_MAX ||
> >>>>>>> +           wfhw->duty_ticks > FIELD_MAX(SUN8I_PWM_PPR_DUTY_MASK)=
)))
> >>>>>>> +             return -EINVAL;
> >>>>>>> +
> >>>>>>> +     if (!wfhw->bypass_en) {
> >>>>>>> +             ret =3D sun8i_pwm_clear_idle_deadzone(sun8i_chip, p=
wm->hwpwm);
> >>>>>>> +             if (ret)
> >>>>>>> +                     return ret;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     current_rate =3D clk_get_rate(chan->pair_clk);
> >>>>>>> +     if (!current_rate || current_rate > U32_MAX)
> >>>>>>> +             return -ERANGE;
> >>>>>>> +     bus_rate =3D clk_get_rate(sun8i_chip->bus_clk);
> >>>>>>> +
> >>>>>>> +     if (!wfhw->bypass_en) {
> >>>>>>> +             /* Do not overwrite a PPR update which has not latc=
hed yet. */
> >>>>>>> +             ret =3D sun8i_pwm_wait_period_ready(sun8i_chip, pwm=
->hwpwm,
> >>>>>>> +                                               &timeout_us);
> >>>>>>> +             if (ret) {
> >>>>>>> +                     dev_err_ratelimited(dev, "pwm#%u: update ti=
meout after %llu us\n",
> >>>>>>> +                                         pwm->hwpwm, timeout_us)=
;
> >>>>>>> +                     return ret;
> >>>>>>> +             }
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     was_enabled =3D sun8i_pwm_channel_is_enabled_locked(sun8i_c=
hip,
> >>>>>>> +                                                       pwm->hwpw=
m);
> >>>>>>> +     val =3D sun8i_pwm_readl(sun8i_chip,
> >>>>>>> +                           SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(pwm=
->hwpwm)));
> >>>>>>> +     current_bypass =3D !!(val &
> >>>>>>> +                                BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pw=
m->hwpwm)));
> >>>>>>> +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpw=
m));
> >>>>>>> +     ppr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpw=
m));
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +     current_div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, p=
cr) + 1;
> >>>>>>> +
> >>>>>>> +     if (current_rate !=3D wfhw->pair_rate &&
> >>>>>>> +         sun8i_pwm_pair_rate_constrained(sun8i_chip, pwm->hwpwm)=
)
> >>>>>>> +             return -EBUSY;
> >>>>>>> +
> >>>>>>> +     if (was_enabled && !READ_ONCE(chan->rate_exclusive)) {
> >>>>>>> +             ret =3D clk_rate_exclusive_get(chan->pair_clk);
> >>>>>>> +             if (ret)
> >>>>>>> +                     return ret;
> >>>>>>> +             WRITE_ONCE(chan->rate_exclusive, true);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Updating PPR while running is safe only if the input clo=
cks and
> >>>>>>> +      * polarity remain unchanged and PCLK is faster than the PW=
M clock.
> >>>>>>> +      * Otherwise stop the channel before touching its configura=
tion.
> >>>>>>> +      */
> >>>>>>> +     needs_quiesce =3D was_enabled &&
> >>>>>>> +             (current_bypass !=3D wfhw->bypass_en ||
> >>>>>>> +              current_rate !=3D wfhw->pair_rate ||
> >>>>>>> +              (!wfhw->bypass_en &&
> >>>>>>> +               (!!(pcr & SUN8I_PWM_PCR_ACTIVE_STATE) !=3D
> >>>>>>> +                wfhw->active_state ||
> >>>>>>> +                current_div_k !=3D wfhw->div_k ||
> >>>>>>> +                (pcr & SUN8I_PWM_PCR_MODE) ||
> >>>>>>> +                !bus_rate ||
> >>>>>>> +                bus_rate <=3D DIV_ROUND_UP_ULL(wfhw->pair_rate,
> >>>>>>> +                                                  wfhw->div_k)))=
);
> >>>>>>> +
> >>>>>>> +     if (needs_quiesce) {
> >>>>>>> +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm=
, false);
> >>>>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (!was_enabled && !READ_ONCE(chan->rate_exclusive)) {
> >>>>>>> +             if (current_rate =3D=3D wfhw->pair_rate)
> >>>>>>> +                     ret =3D clk_rate_exclusive_get(chan->pair_c=
lk);
> >>>>>>> +             else
> >>>>>>> +                     ret =3D clk_set_rate_exclusive(chan->pair_c=
lk,
> >>>>>>> +                                                  wfhw->pair_rat=
e);
> >>>>>>> +             if (ret)
> >>>>>>> +                     return ret;
> >>>>>>> +             WRITE_ONCE(chan->rate_exclusive, true);
> >>>>>>> +             acquired_exclusive =3D true;
> >>>>>>> +     } else if (current_rate !=3D wfhw->pair_rate) {
> >>>>>>> +             ret =3D clk_set_rate(chan->pair_clk, wfhw->pair_rat=
e);
> >>>>>>> +             if (ret)
> >>>>>>> +                     goto restore_enable;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (clk_get_rate(chan->pair_clk) !=3D wfhw->pair_rate) {
> >>>>>>> +             ret =3D -EINVAL;
> >>>>>>> +             goto restore_rate;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (!wfhw->bypass_en) {
> >>>>>>> +             /* Return the channel to cycle mode without replayi=
ng W1S bits. */
> >>>>>>> +             pcr &=3D ~(SUN8I_PWM_PCR_PRESCAL_K_MASK |
> >>>>>>> +                      SUN8I_PWM_PCR_ACTIVE_STATE | SUN8I_PWM_PCR=
_MODE |
> >>>>>>> +                      SUN8I_PWM_PCR_PULSE_START |
> >>>>>>> +                      SUN8I_PWM_PCR_PERIOD_READY);
> >>>>>>> +             pcr |=3D FIELD_PREP(SUN8I_PWM_PCR_PRESCAL_K_MASK,
> >>>>>>> +                               wfhw->div_k - 1);
> >>>>>>> +             if (wfhw->active_state)
> >>>>>>> +                     pcr |=3D SUN8I_PWM_PCR_ACTIVE_STATE;
> >>>>>>> +             sun8i_pwm_writel(sun8i_chip, pcr, SUN8I_PWM_PCR(pwm=
->hwpwm));
> >>>>>>> +
> >>>>>>> +             val =3D SUN8I_PWM_PPR_DUTY(wfhw->duty_ticks);
> >>>>>>> +             val |=3D SUN8I_PWM_PPR_PERIOD(wfhw->period_ticks);
> >>>>>>> +             old_ns =3D 0;
> >>>>>>> +             if (was_enabled && !current_bypass) {
> >>>>>>> +                     old_ticks =3D SUN8I_PWM_PPR_PERIOD_VALUE(pp=
r);
> >>>>>>> +                     old_ns =3D sun8i_pwm_ticks_to_ns(old_ticks,=
 current_div_k,
> >>>>>>> +                                                    current_rate=
);
> >>>>>>> +             }
> >>>>>>> +             new_ns =3D sun8i_pwm_ticks_to_ns(wfhw->period_ticks=
,
> >>>>>>> +                                            wfhw->div_k, wfhw->p=
air_rate);
> >>>>>>> +             chan->pending_period_ns =3D max(old_ns, new_ns);
> >>>>>>> +             sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PPR(pwm=
->hwpwm));
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, wfhw->b=
ypass_en);
> >>>>>>> +     sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, true);
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +
> >>>>>>> +restore_rate:
> >>>>>>> +     if (current_rate !=3D wfhw->pair_rate) {
> >>>>>>> +             restore_ret =3D clk_set_rate(chan->pair_clk, curren=
t_rate);
> >>>>>>> +             restored_rate =3D clk_get_rate(chan->pair_clk);
> >>>>>>> +             if (restore_ret || restored_rate !=3D current_rate)=
 {
> >>>>>>> +                     dev_err(dev,
> >>>>>>> +                             "pwm#%u: failed to restore pair clo=
ck rate %lu: %d (got %lu)\n",
> >>>>>>> +                             pwm->hwpwm, current_rate, restore_r=
et,
> >>>>>>> +                             restored_rate);
> >>>>>>> +                     can_restore_enable =3D false;
> >>>>>>> +             }
> >>>>>>> +     }
> >>>>>>> +     if (acquired_exclusive) {
> >>>>>>> +             clk_rate_exclusive_put(chan->pair_clk);
> >>>>>>> +             WRITE_ONCE(chan->rate_exclusive, false);
> >>>>>>> +     }
> >>>>>>> +restore_enable:
> >>>>>>> +     if (needs_quiesce && can_restore_enable) {
> >>>>>>> +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm=
, true);
> >>>>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     return ret;
> >>>>>>
> >>>>>> For a function that is supposed to just write wfhw into the hardwa=
re
> >>>>>> that is really complicated. Is this really necessary?
> >>>>>
> >>>>> There was avoidable complexity here. V9 encodes the channel registe=
r
> >>>>> values during waveform conversion and uses one preparation helper f=
or
> >>>>> rate protection, quiescing and rollback. The write callback then ap=
plies
> >>>>> those values, without the redundant private-field validation.
> >>>>>
> >>>>> I kept the pending-period handshake and the checks for whether an u=
pdate
> >>>>> can safely run live. Clock, prescaler, polarity and bypass transiti=
ons
> >>>>> may require stopping the output. After a failed rate change, restar=
ting
> >>>>> it also requires restoring the old clock first; otherwise the old
> >>>>> register values could produce a different waveform.
> >>>>>
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +struct sun8i_pwm_rounding {
> >>>>>>> +     const struct pwm_waveform *requested;
> >>>>>>> +     struct sun8i_pwm_waveform best;
> >>>>>>> +     struct pwm_waveform best_wf;
> >>>>>>> +     u32 current_pair_rate;
> >>>>>>> +     bool have_best;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +static bool
> >>>>>>> +sun8i_pwm_candidate_is_better(const struct sun8i_pwm_rounding *r=
ounding,
> >>>>>>> +                           const struct sun8i_pwm_waveform *cand=
idate,
> >>>>>>> +                           const struct pwm_waveform *candidate_=
wf)
> >>>>>>> +{
> >>>>>>> +     const struct pwm_waveform *requested =3D rounding->requeste=
d;
> >>>>>>> +     bool candidate_period_down, best_period_down;
> >>>>>>> +
> >>>>>>> +     /* A zero-duty, zero-offset cycle-mode candidate always exi=
sts. */
> >>>>>>> +     if (candidate_wf->duty_length_ns > requested->duty_length_n=
s ||
> >>>>>>> +         candidate_wf->duty_offset_ns > requested->duty_offset_n=
s)
> >>>>>>> +             return false;
> >>>>>>> +
> >>>>>>> +     if (!rounding->have_best)
> >>>>>>> +             return true;
> >>>>>>> +
> >>>>>>> +     candidate_period_down =3D
> >>>>>>> +             candidate_wf->period_length_ns <=3D requested->peri=
od_length_ns;
> >>>>>>> +     best_period_down =3D
> >>>>>>> +             rounding->best_wf.period_length_ns <=3D requested->=
period_length_ns;
> >>>>>>> +     if (candidate_period_down !=3D best_period_down)
> >>>>>>> +             return candidate_period_down;
> >>>>>>> +
> >>>>>>> +     if (candidate_wf->period_length_ns !=3D
> >>>>>>> +         rounding->best_wf.period_length_ns) {
> >>>>>>> +             if (candidate_period_down)
> >>>>>>> +                     return candidate_wf->period_length_ns >
> >>>>>>> +                            rounding->best_wf.period_length_ns;
> >>>>>>> +
> >>>>>>> +             return candidate_wf->period_length_ns <
> >>>>>>> +                    rounding->best_wf.period_length_ns;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (candidate_wf->duty_length_ns !=3D
> >>>>>>> +         rounding->best_wf.duty_length_ns)
> >>>>>>> +             return candidate_wf->duty_length_ns >
> >>>>>>> +                    rounding->best_wf.duty_length_ns;
> >>>>>>> +
> >>>>>>> +     if (candidate_wf->duty_offset_ns !=3D
> >>>>>>> +         rounding->best_wf.duty_offset_ns)
> >>>>>>> +             return candidate_wf->duty_offset_ns >
> >>>>>>> +                    rounding->best_wf.duty_offset_ns;
> >>>>>>> +
> >>>>>>> +     /* Avoid a shared pair-rate change when two settings are eq=
uivalent. */
> >>>>>>> +     return candidate->pair_rate =3D=3D rounding->current_pair_r=
ate &&
> >>>>>>> +            rounding->best.pair_rate !=3D rounding->current_pair=
_rate;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void
> >>>>>>> +sun8i_pwm_consider_candidate(struct sun8i_pwm_rounding *rounding=
,
> >>>>>>> +                          const struct sun8i_pwm_waveform *candi=
date)
> >>>>>>> +{
> >>>>>>> +     struct pwm_waveform candidate_wf;
> >>>>>>> +
> >>>>>>> +     sun8i_pwm_waveform_to_ns(candidate, &candidate_wf);
> >>>>>>> +     if (!sun8i_pwm_candidate_is_better(rounding, candidate,
> >>>>>>> +                                        &candidate_wf))
> >>>>>>> +             return;
> >>>>>>> +
> >>>>>>> +     rounding->best =3D *candidate;
> >>>>>>> +     rounding->best_wf =3D candidate_wf;
> >>>>>>> +     rounding->have_best =3D true;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void
> >>>>>>> +sun8i_pwm_consider_normal(struct sun8i_pwm_rounding *rounding, u=
32 pair_rate,
> >>>>>>> +                       u16 div_k)
> >>>>>>> +{
> >>>>>>> +     const struct pwm_waveform *requested =3D rounding->requeste=
d;
> >>>>>>> +     struct sun8i_pwm_waveform candidate =3D {
> >>>>>>> +             .enabled =3D true,
> >>>>>>> +             .pair_rate =3D pair_rate,
> >>>>>>> +             .div_k =3D div_k,
> >>>>>>> +     };
> >>>>>>> +     u64 denominator =3D NSEC_PER_SEC * (u64)div_k;
> >>>>>>> +     u64 duty_ticks, period_ticks;
> >>>>>>> +     u64 duty_ns =3D requested->duty_length_ns;
> >>>>>>> +     u64 period_ns =3D requested->period_length_ns;
> >>>>>>> +     u32 inactive_ticks;
> >>>>>>> +
> >>>>>>> +     period_ticks =3D mul_u64_u64_div_u64(period_ns, pair_rate, =
denominator);
> >>>>>>> +     period_ticks =3D clamp_t(u64, period_ticks, 1, SUN8I_PWM_PP=
R_PERIOD_MAX);
> >>>>>>> +     candidate.period_ticks =3D period_ticks;
> >>>>>>> +     if (candidate.period_ticks > 1 &&
> >>>>>>> +         sun8i_pwm_ticks_to_ns(candidate.period_ticks, div_k, pa=
ir_rate) >
> >>>>>>> +         requested->period_length_ns)
> >>>>>>> +             candidate.period_ticks--;
> >>>>>>> +
> >>>>>>> +     duty_ticks =3D mul_u64_u64_div_u64(duty_ns, pair_rate, deno=
minator);
> >>>>>>> +     duty_ticks =3D min_t(u64, duty_ticks, candidate.period_tick=
s);
> >>>>>>> +     if (duty_ticks &&
> >>>>>>> +         sun8i_pwm_ticks_to_ns(duty_ticks, div_k, pair_rate) >
> >>>>>>> +         requested->duty_length_ns)
> >>>>>>> +             duty_ticks--;
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Zero active ticks encode either constant level. For a to=
ggling
> >>>>>>> +      * waveform, active-low mode places the rising edge after t=
he inactive
> >>>>>>> +      * part, which is the only non-zero offset supported by the=
 hardware.
> >>>>>>> +      */
> >>>>>>> +     if (!duty_ticks) {
> >>>>>>> +             candidate.active_state =3D true;
> >>>>>>> +             candidate.duty_ticks =3D 0;
> >>>>>>> +     } else if (duty_ticks =3D=3D candidate.period_ticks) {
> >>>>>>> +             candidate.active_state =3D false;
> >>>>>>> +             candidate.duty_ticks =3D 0;
> >>>>>>> +     } else {
> >>>>>>> +             inactive_ticks =3D candidate.period_ticks - duty_ti=
cks;
> >>>>>>> +             if (sun8i_pwm_ticks_to_ns(inactive_ticks, div_k, pa=
ir_rate) <=3D
> >>>>>>> +                 requested->duty_offset_ns) {
> >>>>>>> +                     candidate.active_state =3D false;
> >>>>>>> +                     candidate.duty_ticks =3D inactive_ticks;
> >>>>>>> +             } else {
> >>>>>>> +                     candidate.active_state =3D true;
> >>>>>>> +                     candidate.duty_ticks =3D duty_ticks;
> >>>>>>> +             }
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     sun8i_pwm_consider_candidate(rounding, &candidate);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void
> >>>>>>> +sun8i_pwm_consider_pair_rate(struct sun8i_pwm_rounding *rounding=
,
> >>>>>>> +                          u32 pair_rate)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_waveform bypass =3D {
> >>>>>>> +             .duty_ticks =3D 1,
> >>>>>>> +             .period_ticks =3D 1,
> >>>>>>> +             .pair_rate =3D pair_rate,
> >>>>>>> +             .div_k =3D 1,
> >>>>>>> +             .enabled =3D true,
> >>>>>>> +             .active_state =3D true,
> >>>>>>> +             .bypass_en =3D true,
> >>>>>>> +     };
> >>>>>>> +
> >>>>>>> +     for (unsigned int div_k =3D 1; div_k <=3D 256; div_k++)
> >>>>>>> +             sun8i_pwm_consider_normal(rounding, pair_rate, div_=
k);
> >>>>>>> +
> >>>>>>> +     sun8i_pwm_consider_candidate(rounding, &bypass);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_round_waveform_tohw(struct pwm_chip *chip,
> >>>>>>> +                                      struct pwm_device *pwm,
> >>>>>>> +                                      const struct pwm_waveform =
*wf,
> >>>>>>> +                                      void *_wfhw)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(c=
hip);
> >>>>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pw=
m->hwpwm];
> >>>>>>> +     struct sun8i_pwm_pair *pair =3D
> >>>>>>> +             &sun8i_chip->pairs[SUN8I_PWM_PAIR_IDX(pwm->hwpwm)];
> >>>>>>> +     struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>>>> +     struct sun8i_pwm_rounding rounding =3D {
> >>>>>>> +             .requested =3D wf,
> >>>>>>> +     };
> >>>>>>> +     unsigned long current_rate;
> >>>>>>> +
> >>>>>>> +     if (!wf->period_length_ns) {
> >>>>>>> +             *wfhw =3D (struct sun8i_pwm_waveform) {
> >>>>>>> +                     .enabled =3D false,
> >>>>>>> +             };
> >>>>>>> +             return 0;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     current_rate =3D clk_get_rate(chan->pair_clk);
> >>>>>>> +     if (!current_rate || current_rate > U32_MAX)
> >>>>>>> +             return -ERANGE;
> >>>>>>> +     rounding.current_pair_rate =3D current_rate;
> >>>>>>> +
> >>>>>>> +     if (sun8i_pwm_pair_rate_constrained(sun8i_chip, pwm->hwpwm)=
) {
> >>>>>>> +             sun8i_pwm_consider_pair_rate(&rounding, current_rat=
e);
> >>>>>>
> >>>>>> These consider functions make an over-engineered impression on me.=
 Over
> >>>>>> all I have the impression this driver is more complicated than
> >>>>>> necessary. I didn't recheck on Richard's previous iteration, but t=
hat
> >>>>>> seemed simpler (read: better) to me.
> >>>>>
> >>>>> The fixed-rate/divider conversion is now a pure helper, and candida=
te
> >>>>> comparison and selection use one function. The redundant corrective
> >>>>> rounding steps are gone too.
> >>>>>
> >>>>> I retained the bounded search across parents, dividers and bypass s=
o the
> >>>>> choice follows the period, duty and offset ordering rather than a
> >>>>> preferred-parent heuristic. It still handles inverted waveforms,
> >>>>> constant levels and the 65536-tick period boundary.
> >>>>>
> >>>>>>> +     } else {
> >>>>>>> +             for (unsigned int parent_idx =3D 0;
> >>>>>>> +                  parent_idx < clk_hw_get_num_parents(pair->hw);
> >>>>>>> +                  parent_idx++) {
> >>>>>>> +                     struct clk_hw *parent;
> >>>>>>> +                     unsigned long parent_rate;
> >>>>>>> +
> >>>>>>> +                     parent =3D clk_hw_get_parent_by_index(pair-=
>hw, parent_idx);
> >>>>>>> +                     if (!parent)
> >>>>>>> +                             continue;
> >>>>>>> +                     parent_rate =3D clk_hw_get_rate(parent);
> >>>>>>> +                     if (!parent_rate)
> >>>>>>> +                             continue;
> >>>>>>> +
> >>>>>>> +                     for (unsigned int i =3D 0; sun8i_pwm_div_m_=
table[i].div;
> >>>>>>> +                          i++) {
> >>>>>>> +                             u16 div_m =3D sun8i_pwm_div_m_table=
[i].div;
> >>>>>>> +                             u64 pair_rate;
> >>>>>>> +
> >>>>>>> +                             pair_rate =3D DIV_ROUND_UP_ULL(pare=
nt_rate, div_m);
> >>>>>>> +                             if (!pair_rate || pair_rate > U32_M=
AX)
> >>>>>>> +                                     continue;
> >>>>>>> +                             sun8i_pwm_consider_pair_rate(&round=
ing, pair_rate);
> >>>>>>> +                     }
> >>>>>>> +             }
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (!rounding.have_best)
> >>>>>>> +             return -EINVAL;
> >>>>>>> +     *wfhw =3D rounding.best;
> >>>>>>> +
> >>>>>>> +     dev_dbg(pwmchip_parent(chip),
> >>>>>>> +             "pwm#%u: %llu/%llu [+%llu] -> pair-rate=3D%u, div-k=
=3D%u, period=3D%u, duty=3D%u, bypass=3D%u, active-high=3D%u\n",
> >>>>>>> +             pwm->hwpwm, wf->duty_length_ns, wf->period_length_n=
s,
> >>>>>>> +             wf->duty_offset_ns, wfhw->pair_rate, wfhw->div_k,
> >>>>>>> +             wfhw->period_ticks, wfhw->duty_ticks, wfhw->bypass_=
en,
> >>>>>>> +             wfhw->active_state);
> >>>>>>> +
> >>>>>>> +     return rounding.best_wf.period_length_ns > wf->period_lengt=
h_ns;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static const struct pwm_ops sun8i_pwm_ops =3D {
> >>>>>>> +     .request =3D sun8i_pwm_request,
> >>>>>>> +     .free =3D sun8i_pwm_free,
> >>>>>>> +     .sizeof_wfhw =3D sizeof(struct sun8i_pwm_waveform),
> >>>>>>> +     .round_waveform_tohw =3D sun8i_pwm_round_waveform_tohw,
> >>>>>>> +     .round_waveform_fromhw =3D sun8i_pwm_round_waveform_fromhw,
> >>>>>>> +     .read_waveform =3D sun8i_pwm_read_waveform,
> >>>>>>> +     .write_waveform =3D sun8i_pwm_write_waveform,
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +/* Register the shared mux, gate and /div_m clock for each chann=
el pair. */
> >>>>>>> +static int sun8i_pwm_register_pair_clocks(struct device *dev,
> >>>>>>> +                                       struct sun8i_pwm_chip *su=
n8i_chip)
> >>>>>>> +{
> >>>>>>> +     static const struct clk_parent_data parent_data[] =3D {
> >>>>>>> +             { .index =3D 0 },
> >>>>>>> +             { .index =3D 1 },
> >>>>>>> +     };
> >>>>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->n=
pwm, 2);
> >>>>>>> +
> >>>>>>> +     for (unsigned int i =3D 0; i < num_pairs; i++) {
> >>>>>>> +             struct sun8i_pwm_pair *pair =3D &sun8i_chip->pairs[=
i];
> >>>>>>> +             void __iomem *reg =3D sun8i_chip->base + SUN8I_PWM_=
PCCR(i);
> >>>>>>> +             struct clk *pair_clk;
> >>>>>>> +             const char *name;
> >>>>>>> +             int ret;
> >>>>>>> +
> >>>>>>> +             name =3D devm_kasprintf(dev, GFP_KERNEL,
> >>>>>>> +                                   "%s#pwm-clk-src%u%u", dev_nam=
e(dev),
> >>>>>>> +                                    i * 2, i * 2 + 1);
> >>>>>>> +             if (!name)
> >>>>>>> +                     return -ENOMEM;
> >>>>>>> +
> >>>>>>> +             pair->mux.reg =3D reg;
> >>>>>>> +             pair->mux.shift =3D SUN8I_PWM_PCCR_SRC_SHIFT;
> >>>>>>> +             pair->mux.mask =3D SUN8I_PWM_PCCR_SRC_MASK;
> >>>>>>> +             pair->mux.flags =3D CLK_MUX_ROUND_CLOSEST;
> >>>>>>> +             pair->mux.lock =3D &sun8i_chip->lock;
> >>>>>>> +
> >>>>>>> +             pair->chip =3D sun8i_chip;
> >>>>>>> +             pair->index =3D i;
> >>>>>>> +
> >>>>>>> +             pair->divider.reg =3D reg;
> >>>>>>> +             pair->divider.shift =3D SUN8I_PWM_PCCR_DIV_M_SHIFT;
> >>>>>>> +             pair->divider.width =3D SUN8I_PWM_PCCR_DIV_M_WIDTH;
> >>>>>>> +             pair->divider.table =3D sun8i_pwm_div_m_table;
> >>>>>>> +             pair->divider.lock =3D &sun8i_chip->lock;
> >>>>>>> +
> >>>>>>> +             pair->hw =3D devm_clk_hw_register_composite_pdata(d=
ev, name,
> >>>>>>> +                                                             par=
ent_data,
> >>>>>>> +                                                             ARR=
AY_SIZE(parent_data),
> >>>>>>> +                     &pair->mux.hw, &clk_mux_ops,
> >>>>>>> +                     &pair->divider.hw, &clk_divider_ops,
> >>>>>>> +                     &pair->gate_hw, &sun8i_pwm_pair_gate_ops, 0=
);
> >>>>>>> +             if (IS_ERR(pair->hw))
> >>>>>>> +                     return dev_err_probe(dev, PTR_ERR(pair->hw)=
,
> >>>>>>> +                                          "Failed to register pa=
ir %u clock\n", i);
> >>>>>>> +
> >>>>>>> +             pair_clk =3D devm_clk_hw_get_clk(dev, pair->hw, NUL=
L);
> >>>>>>> +             if (IS_ERR(pair_clk))
> >>>>>>> +                     return dev_err_probe(dev, PTR_ERR(pair_clk)=
,
> >>>>>>> +                                          "Failed to get pair %u=
 clock\n", i);
> >>>>>>> +
> >>>>>>> +             pair->rate_nb.notifier_call =3D sun8i_pwm_pair_rate=
_notifier;
> >>>>>>> +             ret =3D devm_clk_notifier_register(dev, pair_clk, &=
pair->rate_nb);
> >>>>>>> +             if (ret)
> >>>>>>> +                     return dev_err_probe(dev, ret,
> >>>>>>> +                                          "Failed to protect pai=
r %u clock rate\n", i);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +/* Register a pair-clock consumer and the bypass clock for each =
channel. */
> >>>>>>> +static int sun8i_pwm_register_channel_clocks(struct device *dev,
> >>>>>>> +                                          struct sun8i_pwm_chip =
*sun8i_chip)
> >>>>>>> +{
> >>>>>>> +     for (unsigned int i =3D 0; i < sun8i_chip->data->npwm; i++)=
 {
> >>>>>>> +             struct sun8i_pwm_channel *chan =3D &sun8i_chip->cha=
nnels[i];
> >>>>>>> +             struct clk_hw *parent =3D sun8i_chip->pairs[SUN8I_P=
WM_PAIR_IDX(i)].hw;
> >>>>>>> +             struct clk_parent_data parent_data =3D { .hw =3D pa=
rent };
> >>>>>>> +             struct clk_init_data init =3D {};
> >>>>>>> +             const char *name;
> >>>>>>> +             int ret;
> >>>>>>> +
> >>>>>>> +             /* Separate handles let CCF arbitrate sibling rate =
exclusivity. */
> >>>>>>> +             chan->pair_clk =3D devm_clk_hw_get_clk(dev, parent,=
 NULL);
> >>>>>>> +             if (IS_ERR(chan->pair_clk))
> >>>>>>> +                     return dev_err_probe(dev, PTR_ERR(chan->pai=
r_clk),
> >>>>>>> +                                          "Failed to get pair cl=
ock for PWM %u\n", i);
> >>>>>>> +
> >>>>>>> +             name =3D devm_kasprintf(dev, GFP_KERNEL, "%s#pwm-by=
pass%u",
> >>>>>>> +                                   dev_name(dev), i);
> >>>>>>> +             if (!name)
> >>>>>>> +                     return -ENOMEM;
> >>>>>>> +
> >>>>>>> +             chan->bypass.chip =3D sun8i_chip;
> >>>>>>> +             chan->bypass.index =3D i;
> >>>>>>> +             init.name =3D name;
> >>>>>>> +             init.ops =3D &sun8i_pwm_bypass_ops;
> >>>>>>> +             init.parent_data =3D &parent_data;
> >>>>>>> +             init.num_parents =3D 1;
> >>>>>>> +             /* Keep the shared pair rate stable for the prepare=
d lifetime. */
> >>>>>>> +             init.flags =3D CLK_SET_RATE_PARENT | CLK_SET_RATE_G=
ATE;
> >>>>>>> +             chan->bypass.hw.init =3D &init;
> >>>>>>> +
> >>>>>>> +             ret =3D devm_clk_hw_register(dev, &chan->bypass.hw)=
;
> >>>>>>> +             if (ret)
> >>>>>>> +                     return dev_err_probe(dev, ret,
> >>>>>>> +                                          "Failed to register by=
pass clock %u\n", i);
> >>>>>>> +
> >>>>>>> +             sun8i_chip->hw_data->hws[i] =3D &chan->bypass.hw;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +/*
> >>>>>>> + * A disabled pair gate makes any set PER bits ineffective. Clea=
r those stale
> >>>>>>> + * enables before a clock consumer can turn the shared gate on a=
nd expose an
> >>>>>>> + * unrequested output.
> >>>>>>> + */
> >>>>>>> +static void
> >>>>>>> +sun8i_pwm_sanitize_disabled_pairs(struct sun8i_pwm_chip *sun8i_c=
hip)
> >>>>>>> +{
> >>>>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->n=
pwm, 2);
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     u32 per;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>>>> +             unsigned int first =3D pair * 2;
> >>>>>>> +             u32 pccr;
> >>>>>>> +
> >>>>>>> +             pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR=
(pair));
> >>>>>>> +             if (pccr & SUN8I_PWM_PCCR_GATE)
> >>>>>>> +                     continue;
> >>>>>>> +
> >>>>>>> +             per &=3D ~SUN8I_PWM_ENABLE(first);
> >>>>>>> +             pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first));
> >>>>>>> +             if (first + 1 < sun8i_chip->data->npwm) {
> >>>>>>> +                     per &=3D ~SUN8I_PWM_ENABLE(first + 1);
> >>>>>>> +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(fi=
rst + 1));
> >>>>>>> +             }
> >>>>>>> +             sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(p=
air));
> >>>>>>> +     }
> >>>>>>> +     sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +/*
> >>>>>>> + * Keep firmware-active outputs running until all declared consu=
mers have had
> >>>>>>> + * a chance to claim them. Once the driver core calls sync_state=
(), any channel
> >>>>>>> + * which still has no PWM or clock owner can be stopped.
> >>>>>>
> >>>>>> Never saw that callback before, I hesitate to like it. The idea is=
 to
> >>>>>> disable the PWMs if there is no consumer after boot-up? If this is
> >>>>>> considered a good idea, I'd prefer to do that at the pwm core leve=
l for
> >>>>>> all drivers/devices in the same way.
> >>>>>
> >>>>> Removed sync_state() and the driver-local unclaimed-output shutdown
> >>>>> policy. V9 leaves firmware-active outputs running until a consumer
> >>>>> changes them, while retaining the hardware-enable checks which prot=
ect
> >>>>> their shared gate and rate.
> >>>>>
> >>>>>>> + */
> >>>>>>> +static void sun8i_pwm_sync_state(struct device *dev)
> >>>>>>> +{
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D dev_get_drvdata(dev);
> >>>>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->n=
pwm, 2);
> >>>>>>> +     unsigned long empty_pairs =3D 0;
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     u32 active, per, unclaimed =3D 0;
> >>>>>>> +
> >>>>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>>>> +             u32 pair_mask =3D sun8i_pwm_pair_enable_mask(sun8i_=
chip, pair);
> >>>>>>> +             u32 owner_mask;
> >>>>>>> +             u32 pdzcr;
> >>>>>>> +
> >>>>>>> +             owner_mask =3D sun8i_pwm_pair_owner_mask_locked(sun=
8i_chip, pair);
> >>>>>>> +             pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZ=
CR(pair));
> >>>>>>> +             /* Dead-zone mode couples both outputs into one wav=
eform. */
> >>>>>>> +             if ((pdzcr & SUN8I_PWM_PDZCR_ENABLE) &&
> >>>>>>> +                 (per & owner_mask))
> >>>>>>> +                     continue;
> >>>>>>> +
> >>>>>>> +             unclaimed |=3D pair_mask & ~owner_mask;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     active =3D per & unclaimed;
> >>>>>>> +     per &=3D ~unclaimed;
> >>>>>>> +     sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
> >>>>>>> +
> >>>>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>>>> +             unsigned int first =3D pair * 2;
> >>>>>>> +             u32 pccr;
> >>>>>>> +
> >>>>>>> +             pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR=
(pair));
> >>>>>>> +             if (unclaimed & SUN8I_PWM_ENABLE(first))
> >>>>>>> +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(fi=
rst));
> >>>>>>> +             if (first + 1 < sun8i_chip->data->npwm &&
> >>>>>>> +                 unclaimed & SUN8I_PWM_ENABLE(first + 1))
> >>>>>>> +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(fi=
rst + 1));
> >>>>>>> +             sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(p=
air));
> >>>>>>> +
> >>>>>>> +             if (!(per & sun8i_pwm_pair_enable_mask(sun8i_chip, =
pair)))
> >>>>>>> +                     empty_pairs |=3D BIT(pair);
> >>>>>>> +     }
> >>>>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Reconcile empty pair gates through CCF. Taking and dropp=
ing a
> >>>>>>> +      * temporary reference leaves a gate with another CCF user =
enabled, but
> >>>>>>> +      * disables a firmware-enabled gate whose software count is=
 still zero.
> >>>>>>> +      */
> >>>>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>>>> +             struct clk *pair_clk;
> >>>>>>> +             int ret;
> >>>>>>> +
> >>>>>>> +             if (!(empty_pairs & BIT(pair)))
> >>>>>>> +                     continue;
> >>>>>>> +
> >>>>>>> +             pair_clk =3D sun8i_chip->channels[pair * 2].pair_cl=
k;
> >>>>>>> +             ret =3D clk_prepare_enable(pair_clk);
> >>>>>>> +             if (ret) {
> >>>>>>> +                     dev_warn(dev, "Failed to synchronize pair %=
u gate: %pe\n",
> >>>>>>> +                              pair, ERR_PTR(ret));
> >>>>>>> +                     continue;
> >>>>>>> +             }
> >>>>>>> +             clk_disable_unprepare(pair_clk);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (active)
> >>>>>>> +             dev_dbg(dev, "disabled unclaimed firmware outputs %=
#x\n", active);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_init_clocks(struct device *dev,
> >>>>>>> +                              struct sun8i_pwm_chip *sun8i_chip)
> >>>>>>> +{
> >>>>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->n=
pwm, 2);
> >>>>>>> +     size_t hw_data_size;
> >>>>>>> +     int ret;
> >>>>>>> +
> >>>>>>> +     sun8i_chip->pairs =3D devm_kcalloc(dev, num_pairs,
> >>>>>>> +                                      sizeof(*sun8i_chip->pairs)=
, GFP_KERNEL);
> >>>>>>> +     if (!sun8i_chip->pairs)
> >>>>>>> +             return -ENOMEM;
> >>>>>>> +
> >>>>>>> +     hw_data_size =3D struct_size(sun8i_chip->hw_data, hws,
> >>>>>>> +                                sun8i_chip->data->npwm);
> >>>>>>> +     sun8i_chip->hw_data =3D devm_kzalloc(dev, hw_data_size, GFP=
_KERNEL);
> >>>>>>> +     if (!sun8i_chip->hw_data)
> >>>>>>> +             return -ENOMEM;
> >>>>>>
> >>>>>> Can you fold these allocations into a single one (that is, have
> >>>>>> devm_pwmchip_alloc() as only allocation call)? That should give be=
tter
> >>>>>> cache locality and reduce fragmentation.
> >>>>>
> >>>>> The three pair objects and six channel objects are now embedded in =
the
> >>>>> private structure allocated by devm_pwmchip_alloc(). The separate o=
necell
> >>>>> table is gone; clock lookup uses the channel array directly. Clock-=
name
> >>>>> allocations and CCF's own allocations remain.
> >>>>>
> >>>>>>> +     sun8i_chip->hw_data->num =3D sun8i_chip->data->npwm;
> >>>>>>> +     sun8i_pwm_sanitize_disabled_pairs(sun8i_chip);
> >>>>>>> +
> >>>>>>> +     ret =3D sun8i_pwm_register_pair_clocks(dev, sun8i_chip);
> >>>>>>> +     if (ret)
> >>>>>>> +             return ret;
> >>>>>>> +
> >>>>>>> +     return sun8i_pwm_register_channel_clocks(dev, sun8i_chip);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static int sun8i_pwm_probe(struct platform_device *pdev)
> >>>>>>> +{
> >>>>>>> +     const struct sun8i_pwm_data *data;
> >>>>>>> +     struct device *dev =3D &pdev->dev;
> >>>>>>> +     struct sun8i_pwm_chip *sun8i_chip;
> >>>>>>> +     struct reset_control *rst;
> >>>>>>> +     struct pwm_chip *chip;
> >>>>>>> +     int ret;
> >>>>>>> +
> >>>>>>> +     data =3D of_device_get_match_data(dev);
> >>>>>>> +     if (!data)
> >>>>>>> +             return dev_err_probe(dev, -ENODEV,
> >>>>>>> +                                  "Missing specific data structu=
re\n");
> >>>>>>> +
> >>>>>>> +     chip =3D devm_pwmchip_alloc(dev, data->npwm, sizeof(*sun8i_=
chip));
> >>>>>>> +     if (IS_ERR(chip))
> >>>>>>> +             return dev_err_probe(dev, PTR_ERR(chip),
> >>>>>>> +                                  "Failed to allocate pwmchip\n"=
);
> >>>>>>> +
> >>>>>>> +     sun8i_chip =3D sun8i_pwm_from_chip(chip);
> >>>>>>> +     sun8i_chip->data =3D data;
> >>>>>>> +     spin_lock_init(&sun8i_chip->lock);
> >>>>>>> +     sun8i_chip->base =3D devm_platform_ioremap_resource(pdev, 0=
);
> >>>>>>> +     if (IS_ERR(sun8i_chip->base))
> >>>>>>> +             return dev_err_probe(dev, PTR_ERR(sun8i_chip->base)=
,
> >>>>>>> +                                  "Failed to get PWM base addres=
s\n");
> >>>>>>> +
> >>>>>>> +     sun8i_chip->bus_clk =3D devm_clk_get_enabled(dev, "bus");
> >>>>>>> +     if (IS_ERR(sun8i_chip->bus_clk))
> >>>>>>> +             return dev_err_probe(dev, PTR_ERR(sun8i_chip->bus_c=
lk),
> >>>>>>> +                                  "Failed to get bus clock\n");
> >>>>>>> +
> >>>>>>> +     rst =3D devm_reset_control_get_shared_deasserted(dev, NULL)=
;
> >>>>>>> +     if (IS_ERR(rst))
> >>>>>>> +             return dev_err_probe(dev, PTR_ERR(rst),
> >>>>>>> +                                  "Failed to get reset control\n=
");
> >>>>>>> +
> >>>>>>> +     sun8i_chip->channels =3D devm_kcalloc(dev, data->npwm,
> >>>>>>> +                                         sizeof(*sun8i_chip->cha=
nnels),
> >>>>>>> +                                         GFP_KERNEL);
> >>>>>>> +     if (!sun8i_chip->channels)
> >>>>>>> +             return dev_err_probe(dev, -ENOMEM,
> >>>>>>> +                                  "Failed to allocate %d channel=
s array\n",
> >>>>>>> +                                  data->npwm);
> >>>>>>> +
> >>>>>>> +     chip->ops =3D &sun8i_pwm_ops;
> >>>>>>> +
> >>>>>>> +     ret =3D sun8i_pwm_init_clocks(dev, sun8i_chip);
> >>>>>>> +     if (ret)
> >>>>>>> +             return ret;
> >>>>>>> +
> >>>>>>> +     ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_=
get,
> >>>>>>> +                                       sun8i_chip->hw_data);
> >>>>>>> +     if (ret)
> >>>>>>> +             return dev_err_probe(dev, ret, "Failed to add HW cl=
ock provider\n");
> >>>>>>> +
> >>>>>>> +     ret =3D devm_pwmchip_add(dev, chip);
> >>>>>>> +     if (ret < 0)
> >>>>>>> +             return dev_err_probe(dev, ret, "Failed to add PWM c=
hip\n");
> >>>>>>> +
> >>>>>>> +     platform_set_drvdata(pdev, sun8i_chip);
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static const struct sun8i_pwm_data sun50i_h616_pwm_data =3D {
> >>>>>>> +     .npwm =3D 6,
> >>>>>>
> >>>>>> Are there new variants of that hardware already in the pipeline an=
d
> >>>>>> these are known to differ by npwm only? If not, please hardcode th=
at 6,
> >>>>>> or use a dt property (`npwms =3D <6>`). There is no need to do dev=
ice
> >>>>>> variant handling if there is only a single variant.
> >>>>>
> >>>>> Removed the single-variant match data and fixed the topology at six
> >>>>> channels. No npwms property is added.
> >>>>>
> >>>>>>
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +static const struct of_device_id sun8i_pwm_dt_ids[] =3D {
> >>>>>>> +     {
> >>>>>>> +             .compatible =3D "allwinner,sun50i-h616-pwm",
> >>>>>>> +             .data =3D &sun50i_h616_pwm_data,
> >>>>>>> +     }, {
> >>>>>>> +             /* sentinel */
> >>>>>>> +     }
> >>>>>>> +};
> >>>>>>> +MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
> >>>>>>> +
> >>>>>>> +static struct platform_driver sun8i_pwm_driver =3D {
> >>>>>>> +     .driver =3D {
> >>>>>>> +             .name =3D "sun8i-pwm",
> >>>>>>> +             .of_match_table =3D sun8i_pwm_dt_ids,
> >>>>>>> +             .sync_state =3D sun8i_pwm_sync_state,
> >>>>>>> +     },
> >>>>>>> +     .probe =3D sun8i_pwm_probe,
> >>>>>>> +};
> >>>>>>> +module_platform_driver(sun8i_pwm_driver);
> >>>>>>> +
> >>>>>>> +MODULE_AUTHOR("Richard Genoud <richard.genoud@bootlin.com>");
> >>>>>>> +MODULE_DESCRIPTION("Allwinner sun8i PWM driver");
> >>>>>>> +MODULE_LICENSE("GPL");
> >>>>>>>
> >>>>>>> --
> >>>>>>> 2.53.0
> >>>>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Richard Genoud, Bootlin
> >>>> Embedded Linux and Kernel engineering
> >>>> https://bootlin.com
> >>
> >>
> >> --
> >> Richard Genoud, Bootlin
> >> Embedded Linux and Kernel engineering
> >> https://bootlin.com
>
>
> --
> Richard Genoud, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
