Received: from mail-ua2-f41.google.com (mail-ua2-f41.google.com [74.125.226.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49363CEBB9
	for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150500; cv=pass; b=TIyViL1/1s7QrFSJK6jWABK0WT2NfTXYWO0vS+G95RhaVpegt+3Or9DwzKUFiuseQFuzu49yyGlK4h7SPZrFZhQj/hu17lDjmCwmV0Oniy02cPVyWPMHQytEcqShpP8LRjg/M7+HCAv10ZREibtWHjVsIjaDTvfqCoTEZyamIY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150500; c=relaxed/simple;
	bh=RqmoD0iorZJtRGCZ5gfj9Ld/JttpOcL0uj+ZLePIyvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3X0q+s/QUmCPPPl1CJ4giR7rRGCGjSV4Blh9KfqeQztHldpTJK1J3PBgZUlWi/lq1zH0xuOySvTJE4O2r9paXI4sX/Gk4971t9nZ5VbNN9RP83dNWv/HkRiXHxwsnf6ohfa1KgY3A8vCGjnvH5D4K7YO6vHZd8Bx2z3l/j/2x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etesgIU5; arc=pass smtp.client-ip=74.125.226.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etesgIU5"
Received: by mail-ua2-f41.google.com with SMTP id a1e0cc1a2514c-9809f3af20cso207889241.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 01:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790150494; cv=none;
        d=google.com; s=arc-20260327;
        b=spFf+VgzWXXwN2ZqXZaAmryauHOq2Pf4fR5lOqVQKphBZCL+3iEcu++JgHGBK9ZES3
         Ab1dpCLZLMmd/RQ3t4UqRR5sk5JRWlvaCKMh6rZmw7L2Q/BOomqQaJ12dCdDq9g8oGZO
         01iBlWk+m28zQk/WjssVwQYw0CnrFQtBSN29/r/4zkclY5eiYcJBcNsD6awTwahn0Lzj
         U5IK6YYPh5L7fESo9HDRnpFYD48MilyNpLWIJjPegsAY0C+LjAjSoigmJKY3dn6jK89s
         88VYeHmZCRgJ5cbenDqspboVW2NBnLxJTs/evxaRfgmYpgR63e8O9FhRhBEi4Cvj/Jms
         vpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G95RH5zO2oapHumGErWdMQf1TeWEOuUxj0vW0no/wK0=;
        fh=8RiN3PXo3UC2E4SiuG8LE0AjVS+bqH06TIwFn6eUnD8=;
        b=RLZmijGe5nwZSZAprBKuh1lSugvbY6d724jdB2r0wv/gMprvLexB73PDBonPdrMTs/
         56253FXv7EgujrWeZsvLfkL5gGNMc3r+noX760M8s/yxcLOiFwMQTXSNUVA2CD0DehYV
         86OKY2yFoJap1C/35A7EpY4RSn5KsRHK/ohiRReuGCHoH8DLF0zN5QX7ElysdZwTFamL
         PULndr3oyhvCGkQVe/gAbrGLAV8og7gPETpQuRcYgsWU4UOEds86fW75a3pO0rSqfPd9
         591lRqqkyFopF1JosiXyAS9JLI7kpMuPy73GU2aVo9mH72f/85uyzgjUtpsnJ6x3i6JD
         7nAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790150494; x=1790755294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G95RH5zO2oapHumGErWdMQf1TeWEOuUxj0vW0no/wK0=;
        b=etesgIU5oG7+nIhLVGTYWU0ei/cg8QVcJgxfbWg5JgdnxuRnwzSwSTL/g9y4fMbJLr
         GoLdxEP7mqg6m2LLFBysx//xE5en7tn6ANq5Mg9sPlBrHPPj++74cLRgL8tleS6T7P24
         d+i7flDKWyjXkr6yvpewDDjzemD5JnnF1YlmIV06Pn7KYyhGoc1nT00qF43mDHxCT7d8
         Bo26lhidQBq4yblt6vb9/HO1cqc1LuAhVrERpb94TTaHr7XDats/rOG5li2ePtzcdrNy
         xcAd7cPpzP3e+U2s3rH0/hj/B0ZsJ32kV0xaPVRBcKrb1+bBJNuoXnf4uHa4XRgcmRNf
         xHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150494; x=1790755294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G95RH5zO2oapHumGErWdMQf1TeWEOuUxj0vW0no/wK0=;
        b=xNjsVIG9NST0xU/c/iJCny2G+lecrGuyn7M2sVpKJR1OWM4nHrlomCvRyq5eS62Yqw
         SA25gxGPS775FJCT8a1usRetqI3UQIHDQkTKJk4Q4vz6Fy3+EII0KjU7k/Rkf3GZ8C4D
         GlWdXhXcZxN9ISM+q68Oan2RySIeuH3TJSyqf+vU9p35gnTox45NRY4nZzzj2mB+SnRk
         cbWtJ/KajajHr35dTjZ6j01CIOlvhOr/n60Fp/sa5dKp5hRqXhhvtYtEmz3PgpppeqKj
         U0YbXhhuUMPbqcTsfdpSPwI1NiS8EYyiE/7ykb1iptrZQO7F5idDTlMye/KF+xRziB81
         iyKA==
X-Forwarded-Encrypted: i=1; AKwUvBxvBxdTaTAG8uJgzbHYslAzrEjCniiE+OLqPRbstB6t8sOLJvGQctsEsCFFpMShTkZcTfXANL7t7QU=@vger.kernel.org
X-Gm-Message-State: AFuF++nt610d3Lr7zYKtI2LOHON7m1BXP8rPJ5haK03fbS2Ak0aPQetj
	eDoRF1eOgbrRlUJOqJCzk3KKvDTbJjKLka5p/CW5GRZsz1W7JENzpFc5FmxTkEPPzlqyn3w0nTu
	As3gBW2KOowf7+x+8PULrv1Rr3s6AxVw=
X-Gm-Gg: AYBFou2oyry/nrr1bVV2t8ICNg/tM6vAaCWC8AT9glc/n2MsNyvvuTF0AN6SW90QOrB
	bZ93qIL5q5Ea/PBZbKz/uOhJff61tsLHkK6bed4nTad8Ps8I2TUiicFBQBdu3asle/gfuiHuWqy
	nFddDSAG6qrat8Ltxhtzt3XLMQ2TJg+TJ/0XYf4A5FmrVoLWQVbeMs8qRYx3FKkCkgZ86I6iqvz
	De0pHGY9XLMhqDXy5OndCRjkrPl1+JJH3VusAlFDem++djfb/IGMjRKbc8qlwXdsgUPR7s1BrJK
	lCPnk2WDr9TTxTfM61l1endX8LE6ErhmmO4nCf0rO+fDCGslyIdOC1luUGJe90tcKBkE0Y/4U6z
	CoBAEMK4tLiKKplDEhLUkxiuJJJcafetpaHQ+PVo7kk+QASZRhfxpwiEsvbbxoyR73d1Q6ezz7b
	vnV+X7Y0P2T4Db2aMFp+MUTIlXNCyQqPmYJnqp8hBRIrw/
X-Received: by 2002:a05:6102:5e84:b0:7a8:10eb:976e with SMTP id
 ada2fe7eead31-7ac1acd5e18mr1715798137.4.1790150493826; Wed, 23 Sep 2026
 01:01:33 -0700 (PDT)
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
 <58145d8f-dd16-4cc2-b2ea-d475462241ab@bootlin.com>
In-Reply-To: <58145d8f-dd16-4cc2-b2ea-d475462241ab@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 23 Sep 2026 02:01:21 -0600
X-Gm-Features: AclHuK_sN1Jx_BOU463CKaGQg1VmgJqdbk93BEqwt3OHxc_MzWQxp1tGn_Ja4kk
Message-ID: <CADvTj4oUpx7E2mrBgbZgUcFc6Mkt2Tn2mpwSBPdKk2MG6dmkDg@mail.gmail.com>
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

On Wed, Sep 23, 2026 at 1:16=E2=80=AFAM Richard GENOUD
<richard.genoud@bootlin.com> wrote:
>
> Le 22/09/2026 =C3=A0 17:46, James Hilliard a =C3=A9crit :
> > On Tue, Sep 22, 2026 at 9:13=E2=80=AFAM Richard GENOUD
> > <richard.genoud@bootlin.com> wrote:
> >>
> >> Le 22/09/2026 =C3=A0 02:27, James Hilliard a =C3=A9crit :
> >>> On Mon, Sep 21, 2026 at 10:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig <uklei=
nek@kernel.org> wrote:
> >>>>
> >>>> On Tue, Aug 04, 2026 at 03:27:25PM -0600, James Hilliard wrote:
> >>>>> From: Richard Genoud <richard.genoud@bootlin.com>
> >>>>>
> >>>>> Add a driver for the Allwinner H616 PWM controller, supporting six
> >>>>> channels. Each channel output can carry either a PWM waveform or a =
clock
> >>>>> from its bypass path.
> >>>>>
> >>>>> The channels are paired as 0/1, 2/3 and 4/5. Each pair shares a mux=
, gate
> >>>>> and prescaler, while each channel has its own prescaler and bypass.
> >>>>>
> >>>>> Register each shared pair mux, divider and gate with the Common Clo=
ck
> >>>>> Framework, and expose each channel bypass as a clock output. Progra=
m the
> >>>>> channel-specific divider directly in the PWM path. Arbitrate each o=
utput
> >>>>> when the PWM is requested or the bypass clock is prepared, and hold=
 the
> >>>>> shared pair rate exclusively while either sibling output is active.
> >>>>>
> >>>>> CCF reference counts do not describe outputs left active by firmwar=
e.
> >>>>> Before disabling a pair gate or changing its rate, also inspect the
> >>>>> hardware channel-enable bits. Preserve inherited outputs through ge=
neric
> >>>>> unused-clock cleanup so declared consumers can claim them. At drive=
r
> >>>>> sync_state(), stop channels which remain unowned and reconcile an e=
mpty
> >>>>> shared pair gate through CCF. This prevents both premature shutdown=
 of a
> >>>>> late-probing consumer and indefinite unclaimed outputs.
> >>>>>
> >>>>> The clock-provider interface is needed because pwm-clock cannot acc=
urately
> >>>>> represent the bypass path. For example, pwm-clock represents 24 MHz=
 as an
> >>>>> integer 42 ns PWM period. The PWM waveform-rounding rules happen to=
 select
> >>>>> the H616 bypass and produce 24 MHz for that request, but the pwm-cl=
ock API
> >>>>> does not require its advertised clock rate to equal the rounded har=
dware
> >>>>> waveform.
> >>>>
> >>>> I don't understand the issue here. When you write pwm-clock, do you =
mean
> >>>> drivers/clk/clk-pwm.c or drivers/pwm/pwm-clk.c? (I guess the former.=
)
> >>>
> >>> Yes, drivers/clk/clk-pwm.c. You're right that the 42 ns period, 21 ns=
 duty
> >>> request selects the 24 MHz bypass when that rate is available.
> >>>
> >>
> >> I've played a bit with the v9, and indeed the 24MHz bypass is selected
> >> when the requested period in between 42ns and 49ns (23.8MHz and 20.4Mh=
z)
> >> So, for those periods, we only have a access to 0%, 50% and 100% duty.
> >> And for the periods between 20ns to 41ns, the 100MHz clock is selected
> >> without bypass:
> >> - 20ns->29ns: 2 period cycles, pwm prd=3D50MHz (so, 0% and 100% duty)
> >> - 30ns->39ns: 3 period cycles, pwm prd=3D33MHz (so, 0%, 50% and 100% d=
uty)
> >> - 40ns->41ns: 4 period cycles, pwm prd=3D25MHz (so, 0%, 33%, 66% and 1=
00%
> >> duty)
> >> - 42ns->49ns: 24MHz bypass (so 0%, 50% and 100% duty)
> >> Then, the 100MHz clock is selected again:
> >> - 50ns->59ns: 5 period cycles, pwm prd=3D20MHz  (so, 0%, 25%, 50%, 75 =
and
> >> 100% duty)
> >> and so on.
> >>
> >> It seems a little bit strange to have a 24MHz clock with only 3 duty
> >> steps available between 42ns and 49ns.
> >
> > Yes, I reproduce those three output levels with the v9 rounding helpers=
.
> > The 50% output uses bypass; constant low and high use cycle mode.
> >
> > However, removing bypass candidates alone doesn't make the driver choos=
e
> > the 40 ns alternative. A single 24 MHz cycle still rounds to 42 ns and
> > wins on period, leaving just constant low/high. The low resolution here
> > is therefore not solely caused by considering bypass.
> >
> >> We have the same behavior at each bypass, for example at 12MHz (24MHz
> >> and /2 prescaler):
> >> for periods 84ns to 89ns, we have the 24MHz/2 bypass selected, with on=
ly
> >> 3 duty steps.
> >> (for 83ns, we have the 100MHz clock and 8 period cycles)
> >> same for 10667ns->10669ns (24MHz/256) =3D> 3 duty steps available
> >> whereas at 10666ns, we have 1066 duty steps available with the 100MHz =
clock.
> >
> > I don't reproduce the three-level limit in that case when the sibling
> > doesn't constrain the pair. Ordinary PWM at 24 MHz with 256 period tick=
s
> > has the same rounded 10667 ns period and provides 257 duty levels,
> > including the two constant levels. For example, 10667/2667 ns and
> > 10667/8000 ns both select cycle mode and round exactly in integer ns.
> Indeed, my bad.
> At those steps, the bypass is not selected, the drivers switches to the
> 24MHz clock. It's selected only between 42ns and 49ns
>
> >
> > Bypass can win a tie for a 50% request if the pair is already at 93750 =
Hz,
> > but the mode and pair rate are reconsidered for the next duty request.
> > Was the sibling holding the pair rate in your test?
> >
> > Also, the short-period duty tables seem off by one: the period register
> > stores ticks minus one. Two 100 MHz ticks allow 0%, 50% and 100%; three
> > allow 0%, 1/3, 2/3 and 100%.
> yes, so we have:
> - 20ns->29ns: 2 period cycles, pwm prd=3D50MHz (so, 0%, 50% and 100% duty=
)
> - 30ns->39ns: 3 period cycles, pwm prd=3D33MHz (so, 0%, 33%, 66% and 100%
> duty)
> - 40ns->41ns: 4 period cycles, pwm prd=3D25MHz (so, 0%, 25%, 50%, 75% and
> 100% duty)
> - 42ns->49ns: 24MHz bypass (so 0%, 50% and 100% duty)
> - 50ns->59ns: 5 period cycles, pwm prd=3D20MHz (so, 0%, 20%, 40%, 60%, 80=
%
> and 100% duty)
>
> >
> >> If the bypass is chosen over a non-bypassed alternative, then we can g=
et
> >> rid of the clk-provider and use pwm-clock instead, but we loose duty
> >> steps around each bypassed frequency.
> >
> > There is still the separate rate-reporting issue. If a sibling holds th=
e
> > pair at 100 MHz, the 42/21 ns request becomes 40/20 ns, i.e. 25 MHz,
> > while pwm-clock continues to advertise its configured 24 MHz. Selecting
> > bypass when it is available doesn't remove that mismatch.
> >
> >> IMHO, the PWM driver has not enough informations to choose between the
> >> bypass and maximizing the duty steps number. That's why I prefer more
> >> duty steps and adding a clock-provider (and also because when the bypa=
ss
> >> is enabled, there's no pulse-width modulation anymore, just a clock :)=
)
> >>
> >> if we had the period, duty_cycle and the max duty steps required as
> >> input, we could choose, but that's not the case.
> >>
> >> So I guess that the real question here is:
> >> Is it better to have more duty steps, or to have a closer clock?
> >
> > The resolution tradeoff is real, but the waveform API currently specifi=
es
> > the ordering: choose the largest period not exceeding the request, then
> > the largest compatible duty length not exceeding the request, then the
> > offset. That's the ordering implemented in v9.
> >
> The ordering stated by pwm_round_waveform_might_sleep() documentation is
> period_length_ns, duty_length_ns and then duty_offset_ns, but what about
> duty steps?
> It's not stated in there because it's not a user input, but still, it's
> a quite important value for a pulse width *modulator*.
>
> My point here is that there's a choice between 2 implementations:
> - Consider the bypass as an emergency tool in order to get frequencies
> that are out of bound of the PWM logic (so that would mean only 100MHz)
> and in this case, we have more duty steps for the other periods, like a
> standard pulse width modulator
> - Or consider that the bypass is part of the PWM logic and don't bother
> looking at duty steps. In this case, it's used to get closer frequencies
> to what is requested, and have only 0/50/100% duty for those case.
> (and for this driver, the only case is for the 42ns to 49ns periods)
>
> I'm more enclined to choose the 1st case, because a bypass bypasses the
> PWM logic (!) and we can say that it's not part of the PWM and should
> only be used for the clk-provider part and to reach the 100MHz PWM
> frequency, but that's only my point of view.

I agree that duty resolution matters. I think the remaining question is
which configurations we should expose to the waveform API, rather than
whether bypass itself is PWM.

Restricting bypass alone would not give the higher-resolution
alternative. With the 24 MHz and 100 MHz parents and an unconstrained
pair, a single 24 MHz cycle still reports a 42 ns period and wins over
40 ns. For example, a 42 ns period / 31 ns high-time request currently
becomes 42/21 ns; without bypass candidates it becomes 42/0 ns, not
40/30 ns.

The same tradeoff occurs entirely in cycle mode: at 84 ns, two 24 MHz
ticks provide three duty levels, while eight 100 MHz ticks provide nine
levels at 80 ns.

So achieving the resolution preference would also require restricting
ordinary cycle-mode candidates or changing the period-first selection
policy.

>
> Regards,
> Richard.
> >>
> >> Regards,
> >> Richard
> >>
> >>>> If you do
> >>>>
> >>>>           compatible =3D "pwm-clock";
> >>>>           clock-frequency =3D <24000000>;
> >>>>           pwms =3D <&pwm0 42 ...>;
> >>>>
> >>>> that should give you a reliable match?!
> >>>>
> >>>>> Exposing the bypass through CCF provides an exact rate request,
> >>>>> conveys that duty-cycle and polarity control are not needed, and ma=
kes the
> >>>>> shared pair clock visible to CCF rate arbitration.
> >>>>
> >>>> Are you "just" suffering that clocks are programmed in Hz which PWMs=
 are
> >>>> programmed in ns and thus your losing precision on divisions?
> >>>
> >>> There is also the distinction between the advertised and resulting ra=
te.
> >>> clk-pwm advertises its configured fixed frequency without checking th=
e
> >>> rounded PWM frequency. If an active sibling holds the shared pair at
> >>> 100 MHz, that same request rounds to 40 ns with 20 ns high time, i.e.
> >>> 25 MHz, while pwm-clock still reports 24 MHz.
> >>>
> >>> The direct provider reports the actual pair rate and exposes its shar=
ed
> >>> rate protection to CCF. CCF can still round a rate request, so this i=
s not
> >>> an unconditional exact-rate guarantee. I've clarified that in v9.
> >>>
> >>>>> Wait for the hardware period-update handshake before replacing PPR.=
 Track
> >>>>> the active and newly programmed periods so normal updates use a tig=
ht
> >>>>> timeout, while an unknown firmware update conservatively allows the=
 maximum
> >>>>> hardware period. Scale the sleep interval to keep the number of MMI=
O polls
> >>>>> bounded even for very long periods.
> >>>>>
> >>>>> Dead-zone mode is not representable by the PWM API. Reject it while=
 either
> >>>>> output in the pair is active, but clear dormant dead-zone enable st=
ate when
> >>>>> both outputs are disabled so stale firmware configuration does not
> >>>>> permanently prevent ordinary PWM use.
> >>>>>
> >>>>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> >>>>> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> >>>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >>>>> ---
> >>>>> Changes v7 -> v8:
> >>>>>     - clear the complete two-bit clock-source selector field
> >>>>>     - leave rate and period registers untouched when disabling a ch=
annel
> >>>>>     - distinguish PWM-owned bypass signals from clock-owned bypass =
outputs
> >>>>>     - round waveforms over all parent, pair-divider, channel-divide=
r and bypass
> >>>>>       choices according to the PWM core ordering
> >>>>>     - encode constant levels without overflowing the 16-bit active-=
cycle field
> >>>>>     - allocate clock topology state per device and use the fixed pa=
rent map
> >>>>>       (reported by Sashiko)
> >>>>>     - use managed clock registrations for complete probe-error clea=
nup
> >>>>>       (reported by Sashiko and suggested by Philipp)
> >>>>>     - deassert reset before registering clocks and keep the reset h=
andle local
> >>>>>       (reported by Sashiko and suggested by Philipp)
> >>>>>     - arbitrate channel ownership in clock prepare/unprepare and se=
lect bypass
> >>>>>       only while the clock output is enabled  (reported by Sashiko)
> >>>>>     - roll back failed PWM requests and serialize channel release
> >>>>>       (reported by Sashiko)
> >>>>>     - protect the shared pair source while either sibling channel i=
s active
> >>>>>       (reported by Sashiko)
> >>>>>     - preserve the 65536-tick duty intermediate before polarity con=
version
> >>>>>       (reported by Sashiko)
> >>>>>     - avoid replaying write-one control bits while changing channel=
 settings
> >>>>>       (reported by Sashiko)
> >>>>>     - keep the hardware-waveform state within the PWM core storage =
limit
> >>>>>     - clarify that either co-packaged AC200 or AC300 PHY uses the b=
ypass clock
> >>>>>     - drop Tested-by tags after the clock implementation was rework=
ed
> >>>>>     - quantize inverted waveforms in hardware ticks and report thei=
r
> >>>>>       physical offset
> >>>>>     - force released channels off so stale waveforms cannot restart=
 with a
> >>>>>       sibling
> >>>>>     - track the active and pending cycle for the period-update hand=
shake and
> >>>>>       adapt the sleep interval to bound MMIO polling on long period=
s
> >>>>>     - quiesce rate, polarity and bypass transitions before reprogra=
mming the
> >>>>>       output
> >>>>>     - clear unsupported pulse mode when programming periodic wavefo=
rms
> >>>>>     - preserve firmware-active outputs through generic unused-clock=
 cleanup,
> >>>>>       stop any still-unclaimed channels at sync_state(), reconcile =
empty pair
> >>>>>       gates through CCF, and reject pair retuning while either outp=
ut is
> >>>>>       active
> >>>>>     - hold pair-rate exclusivity only while an output is active
> >>>>>     - make pair-rate changes transactional and restore a quiesced o=
utput on
> >>>>>       failure
> >>>>>     - clear dormant dead-zone state when both pair outputs are disa=
bled,
> >>>>>       while rejecting active dead-zone and pulse modes which the PW=
M API
> >>>>>       cannot represent
> >>>>>     - correct the hardware topology to show the pair gate before di=
v_m
> >>>>>     - remove unused register definitions and simplify the fixed par=
ent
> >>>>>       topology
> >>>>> ---
> >>>>>    drivers/pwm/Kconfig     |   12 +
> >>>>>    drivers/pwm/Makefile    |    1 +
> >>>>>    drivers/pwm/pwm-sun8i.c | 1542 +++++++++++++++++++++++++++++++++=
++++++++++++++
> >>>>>    3 files changed, 1555 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >>>>> index e8886a9b64d9..e7fd2e66b1aa 100644
> >>>>> --- a/drivers/pwm/Kconfig
> >>>>> +++ b/drivers/pwm/Kconfig
> >>>>> @@ -748,6 +748,18 @@ config PWM_SUN4I
> >>>>>           To compile this driver as a module, choose M here: the mo=
dule
> >>>>>           will be called pwm-sun4i.
> >>>>>
> >>>>> +config PWM_SUN8I
> >>>>> +     tristate "Allwinner sun8i/sun50i PWM support"
> >>>>> +     depends on ARCH_SUNXI || COMPILE_TEST
> >>>>> +     depends on HAS_IOMEM && COMMON_CLK
> >>>>> +     help
> >>>>> +       PWM framework driver for Allwinner controllers whose channe=
ls share
> >>>>> +       paired source clocks. In addition to PWM operation, each ch=
annel's
> >>>>> +       hardware bypass path can be exported as a clock output.
> >>>>> +
> >>>>> +       To compile this driver as a module, choose M here: the modu=
le
> >>>>> +       will be called pwm-sun8i.
> >>>>> +
> >>>>>    config PWM_SUNPLUS
> >>>>>         tristate "Sunplus PWM support"
> >>>>>         depends on ARCH_SUNPLUS || COMPILE_TEST
> >>>>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >>>>> index 5630a521a7cf..9c922b1fd0b4 100644
> >>>>> --- a/drivers/pwm/Makefile
> >>>>> +++ b/drivers/pwm/Makefile
> >>>>> @@ -68,6 +68,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm3=
2.o
> >>>>>    obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >>>>>    obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >>>>>    obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> >>>>> +obj-$(CONFIG_PWM_SUN8I)              +=3D pwm-sun8i.o
> >>>>>    obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> >>>>>    obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >>>>>    obj-$(CONFIG_PWM_TH1520)     +=3D pwm_th1520.o
> >>>>> diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..5c3580a0924d
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/pwm/pwm-sun8i.c
> >>>>> @@ -0,0 +1,1542 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>> +/*
> >>>>> + * Driver for Allwinner sun8i Pulse Width Modulation Controller
> >>>>> + *
> >>>>> + * (C) Copyright 2025 Richard Genoud, Bootlin <richard.genoud@boot=
lin.com>
> >>>>> + * (C) Copyright 2026 James Hilliard <james.hilliard1@gmail.com>
> >>>>> + *
> >>>>> + * Based on drivers/pwm/pwm-sun4i.c with Copyright:
> >>>>> + *
> >>>>> + * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@bootlin=
.com>
> >>>>> + *
> >>>>> + * Channels are paired (0/1, 2/3, 4/5). Each pair shares a clock s=
ource and
> >>>>> + * first prescaler (div_m), while each channel has its own second =
prescaler
> >>>>> + * (div_k) and bypass path.
> >>>>> + *
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/bitfield.h>
> >>>>> +#include <linux/bits.h>
> >>>>> +#include <linux/clk.h>
> >>>>> +#include <linux/clk-provider.h>
> >>>>> +#include <linux/device.h>
> >>>>> +#include <linux/err.h>
> >>>>> +#include <linux/io.h>
> >>>>> +#include <linux/iopoll.h>
> >>>>> +#include <linux/limits.h>
> >>>>> +#include <linux/math64.h>
> >>>>> +#include <linux/module.h>
> >>>>> +#include <linux/notifier.h>
> >>>>> +#include <linux/of.h>
> >>>>> +#include <linux/platform_device.h>
> >>>>> +#include <linux/pwm.h>
> >>>>> +#include <linux/reset.h>
> >>>>> +#include <linux/slab.h>
> >>>>> +#include <linux/spinlock.h>
> >>>>> +#include <linux/time.h>
> >>>>> +
> >>>>> +/* PWMCC Pairs Clock Configuration Registers */
> >>>>> +#define SUN8I_PWM_PCCR(pair)         (0x20 + ((pair) * 0x4))
> >>>>> +#define SUN8I_PWM_PCCR_SRC_SHIFT     7
> >>>>> +#define SUN8I_PWM_PCCR_SRC_MASK              GENMASK(1, 0)
> >>>>> +#define SUN8I_PWM_PCCR_GATE_BIT              4
> >>>>> +#define SUN8I_PWM_PCCR_GATE          BIT(SUN8I_PWM_PCCR_GATE_BIT)
> >>>>> +#define SUN8I_PWM_PCCR_BYPASS_BIT(chan)      ((chan) % 2 + 5)
> >>>>> +#define SUN8I_PWM_PCCR_DIV_M_SHIFT   0
> >>>>> +#define SUN8I_PWM_PCCR_DIV_M_WIDTH   4
> >>>>> +
> >>>>> +/* PWM Enable Register */
> >>>>> +#define SUN8I_PWM_PER                        0x40
> >>>>> +#define SUN8I_PWM_ENABLE(chan)               BIT(chan)
> >>>>> +
> >>>>> +/* PWM Control Register */
> >>>>> +#define SUN8I_PWM_PCR(chan)          (0x60 + (chan) * 0x20)
> >>>>> +#define SUN8I_PWM_PCR_PRESCAL_K_MASK GENMASK(7, 0)
> >>>>> +#define SUN8I_PWM_PCR_ACTIVE_STATE   BIT(8)
> >>>>> +#define SUN8I_PWM_PCR_MODE           BIT(9)
> >>>>> +#define SUN8I_PWM_PCR_PULSE_START    BIT(10)
> >>>>> +#define SUN8I_PWM_PCR_PERIOD_READY   BIT(11) /* 0: ready, 1: busy =
*/
> >>>>> +
> >>>>> +/* PWM Period Register */
> >>>>> +#define SUN8I_PWM_PPR(chan)          (0x64 + (chan) * 0x20)
> >>>>> +#define SUN8I_PWM_PPR_PERIOD_MASK    GENMASK(31, 16)
> >>>>> +#define SUN8I_PWM_PPR_DUTY_MASK              GENMASK(15, 0)
> >>>>> +#define SUN8I_PWM_PPR_PERIOD_VALUE(reg)      (FIELD_GET(SUN8I_PWM_=
PPR_PERIOD_MASK, reg) + 1)
> >>>>> +#define SUN8I_PWM_PPR_DUTY_VALUE(reg)        FIELD_GET(SUN8I_PWM_P=
PR_DUTY_MASK, reg)
> >>>>> +#define SUN8I_PWM_PPR_PERIOD(prd)    FIELD_PREP(SUN8I_PWM_PPR_PERI=
OD_MASK, (prd) - 1)
> >>>>> +#define SUN8I_PWM_PPR_DUTY(dty)              FIELD_PREP(SUN8I_PWM_=
PPR_DUTY_MASK, dty)
> >>>>> +#define SUN8I_PWM_PPR_PERIOD_MAX     (FIELD_MAX(SUN8I_PWM_PPR_PERI=
OD_MASK) + 1)
> >>>>> +
> >>>>> +/* PWM pair dead-zone control registers. */
> >>>>> +#define SUN8I_PWM_PDZCR(pair)                (0x30 + ((pair) * 0x4=
))
> >>>>> +#define SUN8I_PWM_PDZCR_ENABLE               BIT(0)
> >>>>> +
> >>>>> +#define SUN8I_PWM_PERIOD_READY_MARGIN_US     50
> >>>>> +#define SUN8I_PWM_PERIOD_READY_MIN_POLL_US   10
> >>>>> +#define SUN8I_PWM_PERIOD_READY_MAX_POLL_US   10000
> >>>>> +#define SUN8I_PWM_PERIOD_READY_POLL_COUNT    1024
> >>>>> +
> >>>>> +#define SUN8I_PWM_PAIR_IDX(chan)     ((chan) >> 1)
> >>>>> +
> >>>>> +/*
> >>>>> + * Block diagram of the PWM clock controller:
> >>>>> + *
> >>>>> + *             _____      ______      ________
> >>>>> + * OSC24M --->|     |    |      |    |        |
> >>>>> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> SUN8I_PWM_cl=
ock_src_xy
> >>>>> + *            |_____|    |______|    |________|
> >>>>> + *                               ________
> >>>>> + *                              |        |
> >>>>> + *                           +->| /div_k |---> SUN8I_PWM_clock_x
> >>>>> + *                           |  |________|
> >>>>> + *                           |    ______
> >>>>> + *                           |   |      |
> >>>>> + *                           +-->| Gate |----> SUN8I_PWM_bypass_cl=
ock_x
> >>>>> + *                           |   |______|
> >>>>> + * SUN8I_PWM_clock_src_xy ---+   ________
> >>>>> + *                           |  |        |
> >>>>> + *                           +->| /div_k |---> SUN8I_PWM_clock_y
> >>>>> + *                           |  |________|
> >>>>> + *                           |    ______
> >>>>> + *                           |   |      |
> >>>>> + *                           +-->| Gate |----> SUN8I_PWM_bypass_cl=
ock_y
> >>>>> + *                               |______|
> >>>>> + *
> >>>>> + * NB: when the bypass is set, all the PWM logic is bypassed.
> >>>>> + * So, the duty cycle and polarity can't be modified (we just have=
 a clock).
> >>>>> + * The bypass in PWM mode is used to achieve a 1/2 relative duty c=
ycle with the
> >>>>> + * fastest clock.
> >>>>> + *
> >>>>> + * SUN8I_PWM_clock_x/y serve for the PWM purpose.
> >>>>> + * SUN8I_PWM_bypass_clock_x/y serve for the clock-provider purpose=
.
> >>>>> + *
> >>>>> + */
> >>>>> +
> >>>>> +/* /div_m is a power-of-two divider limited to /256. */
> >>>>> +static const struct clk_div_table sun8i_pwm_div_m_table[] =3D {
> >>>>> +     { .val =3D 0, .div =3D 1 },
> >>>>> +     { .val =3D 1, .div =3D 2 },
> >>>>> +     { .val =3D 2, .div =3D 4 },
> >>>>> +     { .val =3D 3, .div =3D 8 },
> >>>>> +     { .val =3D 4, .div =3D 16 },
> >>>>> +     { .val =3D 5, .div =3D 32 },
> >>>>> +     { .val =3D 6, .div =3D 64 },
> >>>>> +     { .val =3D 7, .div =3D 128 },
> >>>>> +     { .val =3D 8, .div =3D 256 },
> >>>>> +     { /* sentinel */ }
> >>>>> +};
> >>>>> +
> >>>>> +enum sun8i_pwm_mode {
> >>>>> +     SUN8I_PWM_MODE_NONE,
> >>>>> +     SUN8I_PWM_MODE_PWM,
> >>>>> +     SUN8I_PWM_MODE_CLK,
> >>>>> +};
> >>>>> +
> >>>>> +struct sun8i_pwm_data {
> >>>>> +     unsigned int npwm;
> >>>>> +};
> >>>>> +
> >>>>> +struct sun8i_pwm_chip;
> >>>>> +
> >>>>> +struct sun8i_pwm_pair {
> >>>>> +     struct clk_mux mux;
> >>>>> +     struct clk_hw gate_hw;
> >>>>> +     struct clk_divider divider;
> >>>>> +     struct clk_hw *hw;
> >>>>> +     struct notifier_block rate_nb;
> >>>>> +     struct sun8i_pwm_chip *chip;
> >>>>> +     unsigned int index;
> >>>>> +};
> >>>>> +
> >>>>> +struct sun8i_pwm_bypass {
> >>>>> +     struct clk_hw hw;
> >>>>> +     struct sun8i_pwm_chip *chip;
> >>>>> +     unsigned int index;
> >>>>> +};
> >>>>> +
> >>>>> +struct sun8i_pwm_channel {
> >>>>> +     struct sun8i_pwm_bypass bypass;
> >>>>> +     struct clk *pair_clk;
> >>>>> +     enum sun8i_pwm_mode mode;
> >>>>> +     u64 pending_period_ns;
> >>>>> +     bool rate_exclusive;
> >>>>> +};
> >>>>> +
> >>>>> +struct sun8i_pwm_chip {
> >>>>> +     struct clk_hw_onecell_data *hw_data;
> >>>>> +     struct sun8i_pwm_pair *pairs;
> >>>>> +     struct sun8i_pwm_channel *channels;
> >>>>> +     struct clk *bus_clk;
> >>>>> +     void __iomem *base;
> >>>>> +     const struct sun8i_pwm_data *data;
> >>>>> +     /* Protects shared registers and channel ownership. */
> >>>>> +     spinlock_t lock;
> >>>>> +};
> >>>>> +
> >>>>> +struct sun8i_pwm_waveform {
> >>>>> +     u32 duty_ticks;
> >>>>> +     u32 period_ticks;
> >>>>> +     u32 pair_rate;
> >>>>> +     u16 div_k;
> >>>>> +     u8 enabled:1;
> >>>>> +     u8 active_state:1;
> >>>>> +     u8 bypass_en:1;
> >>>>> +};
> >>>>> +
> >>>>> +static inline struct sun8i_pwm_chip *sun8i_pwm_from_chip(const str=
uct pwm_chip *chip)
> >>>>> +{
> >>>>> +     return pwmchip_get_drvdata(chip);
> >>>>> +}
> >>>>> +
> >>>>> +static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *sun8i_chi=
p,
> >>>>> +                               unsigned long offset)
> >>>>> +{
> >>>>> +     return readl(sun8i_chip->base + offset);
> >>>>> +}
> >>>>> +
> >>>>> +static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *sun8i_c=
hip,
> >>>>> +                                 u32 val, unsigned long offset)
> >>>>> +{
> >>>>> +     writel(val, sun8i_chip->base + offset);
> >>>>> +}
> >>>>> +
> >>>>> +static void sun8i_pwm_set_bypass_locked(struct sun8i_pwm_chip *sun=
8i_chip,
> >>>>> +                                     unsigned int idx, bool enable=
)
> >>>>> +{
> >>>>> +     unsigned long reg_offset;
> >>>>> +     u32 val;
> >>>>> +
> >>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>> +
> >>>>> +     reg_offset =3D SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(idx));
> >>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, reg_offset);
> >>>>> +     if (enable)
> >>>>> +             val |=3D BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> >>>>> +     else
> >>>>> +             val &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> >>>>> +
> >>>>> +     sun8i_pwm_writel(sun8i_chip, val, reg_offset);
> >>>>> +}
> >>>>> +
> >>>>> +static void sun8i_pwm_set_enabled_locked(struct sun8i_pwm_chip *su=
n8i_chip,
> >>>>> +                                      unsigned int idx, bool enabl=
e)
> >>>>> +{
> >>>>> +     u32 val;
> >>>>> +
> >>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>> +
> >>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     if (enable)
> >>>>> +             val |=3D SUN8I_PWM_ENABLE(idx);
> >>>>> +     else
> >>>>> +             val &=3D ~SUN8I_PWM_ENABLE(idx);
> >>>>> +     sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PER);
> >>>>> +}
> >>>>> +
> >>>>> +static bool
> >>>>> +sun8i_pwm_channel_is_enabled_locked(struct sun8i_pwm_chip *sun8i_c=
hip,
> >>>>> +                                 unsigned int idx)
> >>>>> +{
> >>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(idx);
> >>>>> +     u32 pccr, per;
> >>>>> +
> >>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>> +
> >>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +
> >>>>> +     return (pccr & SUN8I_PWM_PCCR_GATE) &&
> >>>>> +            (per & SUN8I_PWM_ENABLE(idx));
> >>>>> +}
> >>>>> +
> >>>>> +static u32 sun8i_pwm_pair_enable_mask(struct sun8i_pwm_chip *sun8i=
_chip,
> >>>>> +                                   unsigned int pair)
> >>>>> +{
> >>>>> +     unsigned int first =3D pair * 2;
> >>>>> +     u32 mask =3D SUN8I_PWM_ENABLE(first);
> >>>>> +
> >>>>> +     if (first + 1 < sun8i_chip->data->npwm)
> >>>>> +             mask |=3D SUN8I_PWM_ENABLE(first + 1);
> >>>>> +
> >>>>> +     return mask;
> >>>>> +}
> >>>>> +
> >>>>> +static u32
> >>>>> +sun8i_pwm_pair_owner_mask_locked(struct sun8i_pwm_chip *sun8i_chip=
,
> >>>>> +                              unsigned int pair)
> >>>>> +{
> >>>>> +     unsigned int first =3D pair * 2;
> >>>>> +     u32 mask =3D 0;
> >>>>> +
> >>>>> +     lockdep_assert_held(&sun8i_chip->lock);
> >>>>> +
> >>>>> +     if (sun8i_chip->channels[first].mode !=3D SUN8I_PWM_MODE_NONE=
)
> >>>>> +             mask |=3D SUN8I_PWM_ENABLE(first);
> >>>>> +     if (first + 1 < sun8i_chip->data->npwm &&
> >>>>> +         sun8i_chip->channels[first + 1].mode !=3D SUN8I_PWM_MODE_=
NONE)
> >>>>> +             mask |=3D SUN8I_PWM_ENABLE(first + 1);
> >>>>> +
> >>>>> +     return mask;
> >>>>> +}
> >>>>> +
> >>>>> +static inline struct sun8i_pwm_pair *
> >>>>> +sun8i_pwm_pair_from_gate_hw(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     return container_of(hw, struct sun8i_pwm_pair, gate_hw);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_pair_gate_enable(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw(h=
w);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>> +     unsigned long flags;
> >>>>> +     u32 pccr;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair->ind=
ex));
> >>>>> +     pccr |=3D SUN8I_PWM_PCCR_GATE;
> >>>>> +     sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pair->index=
));
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static void sun8i_pwm_pair_gate_disable(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw(h=
w);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>> +     unsigned long reg =3D SUN8I_PWM_PCCR(pair->index);
> >>>>> +     unsigned long flags;
> >>>>> +     u32 pccr, per;
> >>>>> +
> >>>>> +     /* CCF counts do not include outputs awaiting firmware-state =
handoff. */
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     if (!(per & sun8i_pwm_pair_enable_mask(sun8i_chip, pair->inde=
x))) {
> >>>>> +             pccr =3D sun8i_pwm_readl(sun8i_chip, reg);
> >>>>> +             pccr &=3D ~SUN8I_PWM_PCCR_GATE;
> >>>>> +             sun8i_pwm_writel(sun8i_chip, pccr, reg);
> >>>>> +     }
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_pair_gate_is_enabled(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_pair *pair =3D sun8i_pwm_pair_from_gate_hw(h=
w);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>> +     unsigned long reg =3D SUN8I_PWM_PCCR(pair->index);
> >>>>> +     unsigned long flags;
> >>>>> +     bool enabled;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     enabled =3D sun8i_pwm_readl(sun8i_chip, reg) & SUN8I_PWM_PCCR=
_GATE;
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return enabled;
> >>>>> +}
> >>>>> +
> >>>>> +static const struct clk_ops sun8i_pwm_pair_gate_ops =3D {
> >>>>> +     .enable =3D sun8i_pwm_pair_gate_enable,
> >>>>> +     .disable =3D sun8i_pwm_pair_gate_disable,
> >>>>> +     .is_enabled =3D sun8i_pwm_pair_gate_is_enabled,
> >>>>> +};
> >>>>> +
> >>>>> +static int sun8i_pwm_pair_rate_notifier(struct notifier_block *nb,
> >>>>> +                                     unsigned long event, void *da=
ta)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_pair *pair =3D
> >>>>> +             container_of(nb, struct sun8i_pwm_pair, rate_nb);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D pair->chip;
> >>>>> +     unsigned long flags;
> >>>>> +     bool active;
> >>>>> +
> >>>>> +     if (event !=3D PRE_RATE_CHANGE)
> >>>>> +             return NOTIFY_DONE;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     active =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER) &
> >>>>> +              sun8i_pwm_pair_enable_mask(sun8i_chip, pair->index);
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return active ? NOTIFY_BAD : NOTIFY_OK;
> >>>>> +}
> >>>>> +
> >>>>> +static inline struct sun8i_pwm_bypass *
> >>>>> +sun8i_pwm_bypass_from_hw(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     return container_of(hw, struct sun8i_pwm_bypass, hw);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_bypass_prepare(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(=
hw);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypa=
ss->index];
> >>>>> +     unsigned long flags;
> >>>>> +     int ret =3D 0;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     if (chan->mode !=3D SUN8I_PWM_MODE_NONE)
> >>>>> +             ret =3D -EBUSY;
> >>>>> +     else
> >>>>> +             chan->mode =3D SUN8I_PWM_MODE_CLK;
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static void sun8i_pwm_bypass_unprepare(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(=
hw);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypa=
ss->index];
> >>>>> +     unsigned long flags;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK))
> >>>>> +             goto out_unlock;
> >>>>> +
> >>>>> +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> >>>>> +
> >>>>> +out_unlock:
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_bypass_enable(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(=
hw);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypa=
ss->index];
> >>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(bypass->index);
> >>>>> +     unsigned long flags;
> >>>>> +     u32 pccr, per;
> >>>>> +     int ret =3D 0;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK)) {
> >>>>> +             ret =3D -EBUSY;
> >>>>> +             goto out_unlock;
> >>>>> +     }
> >>>>> +
> >>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     if (!(pccr & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(bypass->index))) |=
|
> >>>>> +         !(per & SUN8I_PWM_ENABLE(bypass->index))) {
> >>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->inde=
x, false);
> >>>>> +             sun8i_pwm_set_bypass_locked(sun8i_chip, bypass->index=
, true);
> >>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->inde=
x, true);
> >>>>> +     }
> >>>>> +
> >>>>> +out_unlock:
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static void sun8i_pwm_bypass_disable(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(=
hw);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[bypa=
ss->index];
> >>>>> +     unsigned long flags;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_CLK))
> >>>>> +             goto out_unlock;
> >>>>> +
> >>>>> +     sun8i_pwm_set_enabled_locked(sun8i_chip, bypass->index, false=
);
> >>>>> +     sun8i_pwm_set_bypass_locked(sun8i_chip, bypass->index, false)=
;
> >>>>> +
> >>>>> +out_unlock:
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +}
> >>>>> +
> >>>>> +static void sun8i_pwm_bypass_disable_unused(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     /* Defer inherited-output cleanup to sun8i_pwm_sync_state(). =
*/
> >>>>> +}
> >>>>
> >>>> I would expect that you can drop this empty callback?!
> >>>
> >>> Removed in v9, with CLK_IGNORE_UNUSED replacing it. Simply removing t=
he
> >>> callback would make CCF fall back to .disable(). The flag expresses t=
he
> >>> intent to preserve unclaimed firmware outputs through unused-clock
> >>> cleanup; normal consumer disable still turns the output off.
> >>>
> >>>>
> >>>>> +static int sun8i_pwm_bypass_is_enabled(struct clk_hw *hw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_bypass *bypass =3D sun8i_pwm_bypass_from_hw(=
hw);
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D bypass->chip;
> >>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(bypass->index);
> >>>>> +     unsigned long flags;
> >>>>> +     bool enabled;
> >>>>> +     u32 val;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>> +     enabled =3D (val & SUN8I_PWM_PCCR_GATE) &&
> >>>>> +               (val & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(bypass->index)=
));
> >>>>> +
> >>>>> +     val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     enabled =3D enabled && (val & SUN8I_PWM_ENABLE(bypass->index)=
);
> >>>>> +
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return enabled;
> >>>>> +}
> >>>>> +
> >>>>> +static unsigned long sun8i_pwm_bypass_recalc_rate(struct clk_hw *h=
w,
> >>>>> +                                               unsigned long paren=
t_rate)
> >>>>> +{
> >>>>> +     return parent_rate;
> >>>>> +}
> >>>>> +
> >>>>> +static const struct clk_ops sun8i_pwm_bypass_ops =3D {
> >>>>> +     .prepare =3D sun8i_pwm_bypass_prepare,
> >>>>> +     .unprepare =3D sun8i_pwm_bypass_unprepare,
> >>>>> +     .enable =3D sun8i_pwm_bypass_enable,
> >>>>> +     .disable =3D sun8i_pwm_bypass_disable,
> >>>>> +     .disable_unused =3D sun8i_pwm_bypass_disable_unused,
> >>>>> +     .is_enabled =3D sun8i_pwm_bypass_is_enabled,
> >>>>> +     .recalc_rate =3D sun8i_pwm_bypass_recalc_rate,
> >>>>> +};
> >>>>
> >>>> I have problems grokking how the clk and pwm frameworks interact her=
e. I
> >>>> think that would be easier to understand if you split this patch int=
o
> >>>> a basic pwm driver and in a 2nd patch add the clk stuff. Maybe also
> >>>> split out the bypass stuff?
> >>>
> >>> V9 separates PWM support in patch 2 from the exported bypass clocks a=
nd
> >>> PWM/clock ownership arbitration in patch 3.
> >>>
> >>> PWM request/free and clock prepare/unprepare arbitrate ownership of t=
he
> >>> physical output, so the two interfaces cannot own it simultaneously.
> >>>
> >>> The internal CCF pair clocks remain in patch 2, so both patches use t=
he
> >>> same implementation of the shared mux, divider and gate. Hardware byp=
ass
> >>> rounding also stays there: it is part of PWM waveform generation and
> >>> inherited-state readback, independently of exporting a clock provider
> >>>
> >>>>> +static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chi=
p);
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm-=
>hwpwm];
> >>>>> +     unsigned int idx =3D pwm->hwpwm;
> >>>>> +     unsigned long flags;
> >>>>> +     bool was_enabled =3D false;
> >>>>> +     int ret;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     if (chan->mode !=3D SUN8I_PWM_MODE_NONE) {
> >>>>> +             ret =3D -EBUSY;
> >>>>> +     } else {
> >>>>> +             was_enabled =3D
> >>>>> +                     sun8i_pwm_channel_is_enabled_locked(sun8i_chi=
p, idx);
> >>>>> +             chan->mode =3D SUN8I_PWM_MODE_PWM;
> >>>>> +             ret =3D 0;
> >>>>> +     }
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>
> >>>> With scoped_guard() this can be written in a nicer way.
> >>>
> >>> Converted to guard()/scoped_guard() in v9.
> >>>
> >>>>> +     if (was_enabled) {
> >>>>> +             ret =3D clk_rate_exclusive_get(chan->pair_clk);
> >>>>> +             if (ret)
> >>>>> +                     goto err_release_channel;
> >>>>> +             WRITE_ONCE(chan->rate_exclusive, true);
> >>>>> +     }
> >>>>> +
> >>>>> +     ret =3D clk_prepare_enable(chan->pair_clk);
> >>>>> +     if (ret) {
> >>>>> +             if (READ_ONCE(chan->rate_exclusive)) {
> >>>>> +                     clk_rate_exclusive_put(chan->pair_clk);
> >>>>> +                     WRITE_ONCE(chan->rate_exclusive, false);
> >>>>> +             }
> >>>>> +             goto err_release_channel;
> >>>>> +     }
> >>>>> +
> >>>>> +     return 0;
> >>>>> +
> >>>>> +err_release_channel:
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chi=
p);
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm-=
>hwpwm];
> >>>>> +     unsigned long flags;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     if (WARN_ON_ONCE(chan->mode !=3D SUN8I_PWM_MODE_PWM)) {
> >>>>
> >>>> WARN_ON is usually frowned upon, see e.g.
> >>>> https://lore.kernel.org/all/2026091953-cherub-empty-ef35@gregkh/.
> >>>
> >>> Removed the ownership WARN_ON_ONCE() calls.
> >>>
> >>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +             return;
> >>>>> +     }
> >>>>> +
> >>>>> +     sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, false);
> >>>>> +     sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false);
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     if (READ_ONCE(chan->rate_exclusive)) {
> >>>>
> >>>> given this isn't performance critical (is it?) and we have a lock
> >>>> anyhow, I'd prefer to have chan->rate_exclusive protected by that lo=
ck,
> >>>> too, instead of mixing different atomics here.
> >>>
> >>> All accesses to rate_exclusive now use the shared register/ownership
> >>> lock. The CCF operations stay outside that spinlock because they take=
 the
> >>> prepare mutex and can call back into the driver.
> >>>
> >>>>> +             clk_rate_exclusive_put(chan->pair_clk);
> >>>>> +             WRITE_ONCE(chan->rate_exclusive, false);
> >>>>> +     }
> >>>>> +     clk_disable_unprepare(chan->pair_clk);
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     chan->mode =3D SUN8I_PWM_MODE_NONE;
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
> >>>>> +                                struct pwm_device *pwm,
> >>>>> +                                void *_wfhw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chi=
p);
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm-=
>hwpwm];
> >>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(pwm->hwpwm);
> >>>>> +     unsigned long flags, pair_rate;
> >>>>> +     u32 pccr, pcr, pdzcr, per, ppr;
> >>>>> +
> >>>>> +     pair_rate =3D clk_get_rate(chan->pair_clk);
> >>>>> +     if (pair_rate > U32_MAX)
> >>>>> +             return -ERANGE;
> >>>>
> >>>> That should not happen. You lock the rate in .request(). So please c=
heck
> >>>> the rate already there and return an error code.
> >>>
> >>> The rate is only protected while the PWM is active, not for its entir=
e
> >>> requested lifetime. A requested but disabled PWM must still allow its
> >>> sibling to change the pair rate. Also, debugfs reads hardware state f=
or
> >>> channels which have not been requested.
> >>>
> >>> I therefore kept the checks where the rate is used rather than moving
> >>> them solely to .request().
> >>>
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
> >>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm)=
);
> >>>>> +     ppr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm)=
);
> >>>>> +     pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     *wfhw =3D (struct sun8i_pwm_waveform) {
> >>>>> +             .enabled =3D !!(pccr & SUN8I_PWM_PCCR_GATE) &&
> >>>>> +                        !!(per & SUN8I_PWM_ENABLE(pwm->hwpwm)),
> >>>>> +             .bypass_en =3D !!(pccr &
> >>>>> +                              BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pwm->h=
wpwm))),
> >>>>> +             .active_state =3D !!(pcr & SUN8I_PWM_PCR_ACTIVE_STATE=
),
> >>>>> +             .duty_ticks =3D SUN8I_PWM_PPR_DUTY_VALUE(ppr),
> >>>>> +             .period_ticks =3D SUN8I_PWM_PPR_PERIOD_VALUE(ppr),
> >>>>> +             .pair_rate =3D pair_rate,
> >>>>> +             .div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pc=
r) + 1,
> >>>>> +     };
> >>>>> +
> >>>>> +     if (wfhw->enabled && !wfhw->bypass_en &&
> >>>>> +         (pdzcr & SUN8I_PWM_PDZCR_ENABLE))
> >>>>> +             return -EOPNOTSUPP;
> >>>>> +     if (wfhw->enabled && !wfhw->bypass_en &&
> >>>>> +         (pcr & SUN8I_PWM_PCR_MODE))
> >>>>> +             return -EOPNOTSUPP;
> >>>>
> >>>> These need at least a comment.
> >>>
> >>> Added a comment explaining that the waveform API cannot represent pul=
se
> >>> mode or coupled dead-zone operation, and combined the rejection check=
s.
> >>>
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static u64 sun8i_pwm_ticks_to_ns(u32 ticks, u16 div_k, u32 pair_ra=
te)
> >>>>> +{
> >>>>> +     return DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)ticks * div_k,
> >>>>> +                             pair_rate);
> >>>>> +}
> >>>>> +
> >>>>> +static void
> >>>>> +sun8i_pwm_waveform_to_ns(const struct sun8i_pwm_waveform *wfhw,
> >>>>> +                      struct pwm_waveform *wf)
> >>>>> +{
> >>>>> +     u32 pair_rate =3D wfhw->pair_rate;
> >>>>> +     u16 div_k =3D wfhw->div_k;
> >>>>> +
> >>>>> +     wf->duty_offset_ns =3D 0;
> >>>>> +
> >>>>> +     if (!wfhw->enabled || !pair_rate) {
> >>>>> +             wf->period_length_ns =3D 0;
> >>>>> +             wf->duty_length_ns =3D 0;
> >>>>> +             return;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (wfhw->bypass_en) {
> >>>>> +             wf->period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SE=
C,
> >>>>> +                                                     pair_rate);
> >>>>> +             wf->duty_length_ns =3D
> >>>>> +                     DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> >>>>> +                                      2ULL * pair_rate);
> >>>>> +     } else {
> >>>>> +             wf->period_length_ns =3D sun8i_pwm_ticks_to_ns(wfhw->=
period_ticks,
> >>>>> +                                                          div_k, p=
air_rate);
> >>>>> +             if (wfhw->active_state) {
> >>>>> +                     u32 duty_ticks =3D min(wfhw->duty_ticks,
> >>>>> +                                          wfhw->period_ticks);
> >>>>> +
> >>>>> +                     wf->duty_length_ns =3D
> >>>>> +                             sun8i_pwm_ticks_to_ns(duty_ticks, div=
_k, pair_rate);
> >>>>> +             } else if (!wfhw->duty_ticks) {
> >>>>> +                     wf->duty_length_ns =3D wf->period_length_ns;
> >>>>> +             } else if (wfhw->duty_ticks >=3D wfhw->period_ticks) =
{
> >>>>> +                     wf->duty_length_ns =3D 0;
> >>>>> +             } else {
> >>>>> +                     u32 low_ticks =3D wfhw->duty_ticks;
> >>>>> +                     u32 high_ticks =3D wfhw->period_ticks - wfhw-=
>duty_ticks;
> >>>>> +
> >>>>> +                     wf->duty_length_ns =3D
> >>>>> +                             sun8i_pwm_ticks_to_ns(high_ticks, div=
_k, pair_rate);
> >>>>> +                     wf->duty_offset_ns =3D
> >>>>> +                             sun8i_pwm_ticks_to_ns(low_ticks, div_=
k, pair_rate);
> >>>>> +             }
> >>>>> +     }
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> >>>>> +                                        struct pwm_device *pwm,
> >>>>> +                                        const void *_wfhw,
> >>>>> +                                        struct pwm_waveform *wf)
> >>>>> +{
> >>>>> +     const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>> +
> >>>>> +     sun8i_pwm_waveform_to_ns(wfhw, wf);
> >>>>
> >>>> I suggest to rename that function to __sun8i_pwm_round_waveform_from=
hw()
> >>>> or similar to make the relation between the two functions obvious.
> >>>
> >>> Renamed to __sun8i_pwm_round_waveform_fromhw().
> >>>
> >>>>> +     dev_dbg(pwmchip_parent(chip),
> >>>>> +             "pwm#%u: pair-rate=3D%u, div-k=3D%u, period=3D%u, dut=
y=3D%u, bypass=3D%u, active-high=3D%u -> %llu/%llu [+%llu]\n",
> >>>>> +             pwm->hwpwm, wfhw->pair_rate, wfhw->div_k,
> >>>>> +             wfhw->period_ticks, wfhw->duty_ticks, wfhw->bypass_en=
,
> >>>>> +             wfhw->active_state,
> >>>>> +             wf->duty_length_ns, wf->period_length_ns,
> >>>>> +             wf->duty_offset_ns);
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static bool
> >>>>> +sun8i_pwm_pair_rate_constrained(struct sun8i_pwm_chip *sun8i_chip,
> >>>>> +                             unsigned int idx)
> >>>>> +{
> >>>>> +     unsigned int sibling =3D idx ^ 1;
> >>>>> +     unsigned long flags;
> >>>>> +     bool constrained;
> >>>>> +
> >>>>> +     if (sibling >=3D sun8i_chip->data->npwm)
> >>>>> +             return false;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     constrained =3D sun8i_chip->channels[sibling].mode =3D=3D
> >>>>> +                     SUN8I_PWM_MODE_CLK ||
> >>>>> +                   READ_ONCE(sun8i_chip->channels[sibling].rate_ex=
clusive) ||
> >>>>> +                   sun8i_pwm_channel_is_enabled_locked(sun8i_chip,
> >>>>> +                                                       sibling);
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return constrained;
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_clear_idle_deadzone(struct sun8i_pwm_chip *su=
n8i_chip,
> >>>>> +                                      unsigned int idx)
> >>>>> +{
> >>>>> +     unsigned int pair =3D SUN8I_PWM_PAIR_IDX(idx);
> >>>>> +     unsigned long flags;
> >>>>> +     u32 pdzcr, per;
> >>>>> +     int ret =3D 0;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
> >>>>> +     if (!(pdzcr & SUN8I_PWM_PDZCR_ENABLE))
> >>>>> +             goto out_unlock;
> >>>>> +
> >>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     if (per & sun8i_pwm_pair_enable_mask(sun8i_chip, pair)) {
> >>>>> +             ret =3D -EOPNOTSUPP;
> >>>>> +             goto out_unlock;
> >>>>> +     }
> >>>>> +
> >>>>> +     pdzcr &=3D ~SUN8I_PWM_PDZCR_ENABLE;
> >>>>> +     sun8i_pwm_writel(sun8i_chip, pdzcr, SUN8I_PWM_PDZCR(pair));
> >>>>> +
> >>>>> +out_unlock:
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static u64 sun8i_pwm_max_period_ns(struct sun8i_pwm_chip *sun8i_ch=
ip,
> >>>>> +                                unsigned int idx)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[idx]=
;
> >>>>> +     unsigned long flags, pair_rate;
> >>>>> +     u32 pcr;
> >>>>> +     u16 div_k;
> >>>>> +
> >>>>> +     pair_rate =3D clk_get_rate(chan->pair_clk);
> >>>>> +     if (!pair_rate || pair_rate > U32_MAX)
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(idx));
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +     div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pcr) + 1;
> >>>>> +
> >>>>> +     return sun8i_pwm_ticks_to_ns(SUN8I_PWM_PPR_PERIOD_MAX, div_k,
> >>>>> +                                  pair_rate);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_wait_period_ready(struct sun8i_pwm_chip *sun8=
i_chip,
> >>>>> +                                    unsigned int idx, u64 *timeout=
_us)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[idx]=
;
> >>>>> +     unsigned long poll_us;
> >>>>> +     u64 period_ns;
> >>>>> +     u32 val;
> >>>>> +     int ret;
> >>>>> +
> >>>>> +     /* PPR contains the pending value, not necessarily the active=
 period. */
> >>>>> +     period_ns =3D chan->pending_period_ns;
> >>>>> +     if (!period_ns)
> >>>>> +             period_ns =3D sun8i_pwm_max_period_ns(sun8i_chip, idx=
);
> >>>>> +     *timeout_us =3D DIV_ROUND_UP_ULL(period_ns, NSEC_PER_USEC) +
> >>>>> +                   SUN8I_PWM_PERIOD_READY_MARGIN_US;
> >>>>> +     poll_us =3D clamp_t(u64,
> >>>>> +                       DIV_ROUND_UP_ULL(*timeout_us,
> >>>>> +                                        SUN8I_PWM_PERIOD_READY_POL=
L_COUNT),
> >>>>> +                       SUN8I_PWM_PERIOD_READY_MIN_POLL_US,
> >>>>> +                       SUN8I_PWM_PERIOD_READY_MAX_POLL_US);
> >>>>> +
> >>>>> +     ret =3D readl_poll_timeout(sun8i_chip->base + SUN8I_PWM_PCR(i=
dx), val,
> >>>>> +                              !(val & SUN8I_PWM_PCR_PERIOD_READY),=
 poll_us,
> >>>>> +                              *timeout_us);
> >>>>> +     if (!ret)
> >>>>> +             chan->pending_period_ns =3D 0;
> >>>>> +
> >>>>> +     return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_write_waveform(struct pwm_chip *chip,
> >>>>> +                                 struct pwm_device *pwm, const voi=
d *_wfhw)
> >>>>> +{
> >>>>> +     const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chi=
p);
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm-=
>hwpwm];
> >>>>> +     struct device *dev =3D pwmchip_parent(chip);
> >>>>> +     unsigned long bus_rate, current_rate, restored_rate;
> >>>>> +     unsigned long flags;
> >>>>> +     u64 new_ns, old_ns, timeout_us;
> >>>>> +     bool acquired_exclusive =3D false;
> >>>>> +     bool can_restore_enable =3D true;
> >>>>> +     bool current_bypass, needs_quiesce, was_enabled;
> >>>>> +     u16 current_div_k;
> >>>>> +     u32 old_ticks, pcr, ppr, val;
> >>>>> +     int restore_ret, ret;
> >>>>> +
> >>>>> +     if (!wfhw->enabled) {
> >>>>> +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, =
false);
> >>>>> +             sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, f=
alse);
> >>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +             if (READ_ONCE(chan->rate_exclusive)) {
> >>>>> +                     clk_rate_exclusive_put(chan->pair_clk);
> >>>>> +                     WRITE_ONCE(chan->rate_exclusive, false);
> >>>>> +             }
> >>>>> +
> >>>>> +             return 0;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!wfhw->pair_rate ||
> >>>>> +         (!wfhw->bypass_en &&
> >>>>> +          (!wfhw->div_k || wfhw->div_k > 256 ||
> >>>>> +           !wfhw->period_ticks ||
> >>>>> +           wfhw->period_ticks > SUN8I_PWM_PPR_PERIOD_MAX ||
> >>>>> +           wfhw->duty_ticks > FIELD_MAX(SUN8I_PWM_PPR_DUTY_MASK)))=
)
> >>>>> +             return -EINVAL;
> >>>>> +
> >>>>> +     if (!wfhw->bypass_en) {
> >>>>> +             ret =3D sun8i_pwm_clear_idle_deadzone(sun8i_chip, pwm=
->hwpwm);
> >>>>> +             if (ret)
> >>>>> +                     return ret;
> >>>>> +     }
> >>>>> +
> >>>>> +     current_rate =3D clk_get_rate(chan->pair_clk);
> >>>>> +     if (!current_rate || current_rate > U32_MAX)
> >>>>> +             return -ERANGE;
> >>>>> +     bus_rate =3D clk_get_rate(sun8i_chip->bus_clk);
> >>>>> +
> >>>>> +     if (!wfhw->bypass_en) {
> >>>>> +             /* Do not overwrite a PPR update which has not latche=
d yet. */
> >>>>> +             ret =3D sun8i_pwm_wait_period_ready(sun8i_chip, pwm->=
hwpwm,
> >>>>> +                                               &timeout_us);
> >>>>> +             if (ret) {
> >>>>> +                     dev_err_ratelimited(dev, "pwm#%u: update time=
out after %llu us\n",
> >>>>> +                                         pwm->hwpwm, timeout_us);
> >>>>> +                     return ret;
> >>>>> +             }
> >>>>> +     }
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     was_enabled =3D sun8i_pwm_channel_is_enabled_locked(sun8i_chi=
p,
> >>>>> +                                                       pwm->hwpwm)=
;
> >>>>> +     val =3D sun8i_pwm_readl(sun8i_chip,
> >>>>> +                           SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(pwm->=
hwpwm)));
> >>>>> +     current_bypass =3D !!(val &
> >>>>> +                                BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pwm-=
>hwpwm)));
> >>>>> +     pcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm)=
);
> >>>>> +     ppr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm)=
);
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +     current_div_k =3D FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pcr=
) + 1;
> >>>>> +
> >>>>> +     if (current_rate !=3D wfhw->pair_rate &&
> >>>>> +         sun8i_pwm_pair_rate_constrained(sun8i_chip, pwm->hwpwm))
> >>>>> +             return -EBUSY;
> >>>>> +
> >>>>> +     if (was_enabled && !READ_ONCE(chan->rate_exclusive)) {
> >>>>> +             ret =3D clk_rate_exclusive_get(chan->pair_clk);
> >>>>> +             if (ret)
> >>>>> +                     return ret;
> >>>>> +             WRITE_ONCE(chan->rate_exclusive, true);
> >>>>> +     }
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Updating PPR while running is safe only if the input clock=
s and
> >>>>> +      * polarity remain unchanged and PCLK is faster than the PWM =
clock.
> >>>>> +      * Otherwise stop the channel before touching its configurati=
on.
> >>>>> +      */
> >>>>> +     needs_quiesce =3D was_enabled &&
> >>>>> +             (current_bypass !=3D wfhw->bypass_en ||
> >>>>> +              current_rate !=3D wfhw->pair_rate ||
> >>>>> +              (!wfhw->bypass_en &&
> >>>>> +               (!!(pcr & SUN8I_PWM_PCR_ACTIVE_STATE) !=3D
> >>>>> +                wfhw->active_state ||
> >>>>> +                current_div_k !=3D wfhw->div_k ||
> >>>>> +                (pcr & SUN8I_PWM_PCR_MODE) ||
> >>>>> +                !bus_rate ||
> >>>>> +                bus_rate <=3D DIV_ROUND_UP_ULL(wfhw->pair_rate,
> >>>>> +                                                  wfhw->div_k))));
> >>>>> +
> >>>>> +     if (needs_quiesce) {
> >>>>> +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, =
false);
> >>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!was_enabled && !READ_ONCE(chan->rate_exclusive)) {
> >>>>> +             if (current_rate =3D=3D wfhw->pair_rate)
> >>>>> +                     ret =3D clk_rate_exclusive_get(chan->pair_clk=
);
> >>>>> +             else
> >>>>> +                     ret =3D clk_set_rate_exclusive(chan->pair_clk=
,
> >>>>> +                                                  wfhw->pair_rate)=
;
> >>>>> +             if (ret)
> >>>>> +                     return ret;
> >>>>> +             WRITE_ONCE(chan->rate_exclusive, true);
> >>>>> +             acquired_exclusive =3D true;
> >>>>> +     } else if (current_rate !=3D wfhw->pair_rate) {
> >>>>> +             ret =3D clk_set_rate(chan->pair_clk, wfhw->pair_rate)=
;
> >>>>> +             if (ret)
> >>>>> +                     goto restore_enable;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (clk_get_rate(chan->pair_clk) !=3D wfhw->pair_rate) {
> >>>>> +             ret =3D -EINVAL;
> >>>>> +             goto restore_rate;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!wfhw->bypass_en) {
> >>>>> +             /* Return the channel to cycle mode without replaying=
 W1S bits. */
> >>>>> +             pcr &=3D ~(SUN8I_PWM_PCR_PRESCAL_K_MASK |
> >>>>> +                      SUN8I_PWM_PCR_ACTIVE_STATE | SUN8I_PWM_PCR_M=
ODE |
> >>>>> +                      SUN8I_PWM_PCR_PULSE_START |
> >>>>> +                      SUN8I_PWM_PCR_PERIOD_READY);
> >>>>> +             pcr |=3D FIELD_PREP(SUN8I_PWM_PCR_PRESCAL_K_MASK,
> >>>>> +                               wfhw->div_k - 1);
> >>>>> +             if (wfhw->active_state)
> >>>>> +                     pcr |=3D SUN8I_PWM_PCR_ACTIVE_STATE;
> >>>>> +             sun8i_pwm_writel(sun8i_chip, pcr, SUN8I_PWM_PCR(pwm->=
hwpwm));
> >>>>> +
> >>>>> +             val =3D SUN8I_PWM_PPR_DUTY(wfhw->duty_ticks);
> >>>>> +             val |=3D SUN8I_PWM_PPR_PERIOD(wfhw->period_ticks);
> >>>>> +             old_ns =3D 0;
> >>>>> +             if (was_enabled && !current_bypass) {
> >>>>> +                     old_ticks =3D SUN8I_PWM_PPR_PERIOD_VALUE(ppr)=
;
> >>>>> +                     old_ns =3D sun8i_pwm_ticks_to_ns(old_ticks, c=
urrent_div_k,
> >>>>> +                                                    current_rate);
> >>>>> +             }
> >>>>> +             new_ns =3D sun8i_pwm_ticks_to_ns(wfhw->period_ticks,
> >>>>> +                                            wfhw->div_k, wfhw->pai=
r_rate);
> >>>>> +             chan->pending_period_ns =3D max(old_ns, new_ns);
> >>>>> +             sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PPR(pwm->=
hwpwm));
> >>>>> +     }
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, wfhw->byp=
ass_en);
> >>>>> +     sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, true);
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     return 0;
> >>>>> +
> >>>>> +restore_rate:
> >>>>> +     if (current_rate !=3D wfhw->pair_rate) {
> >>>>> +             restore_ret =3D clk_set_rate(chan->pair_clk, current_=
rate);
> >>>>> +             restored_rate =3D clk_get_rate(chan->pair_clk);
> >>>>> +             if (restore_ret || restored_rate !=3D current_rate) {
> >>>>> +                     dev_err(dev,
> >>>>> +                             "pwm#%u: failed to restore pair clock=
 rate %lu: %d (got %lu)\n",
> >>>>> +                             pwm->hwpwm, current_rate, restore_ret=
,
> >>>>> +                             restored_rate);
> >>>>> +                     can_restore_enable =3D false;
> >>>>> +             }
> >>>>> +     }
> >>>>> +     if (acquired_exclusive) {
> >>>>> +             clk_rate_exclusive_put(chan->pair_clk);
> >>>>> +             WRITE_ONCE(chan->rate_exclusive, false);
> >>>>> +     }
> >>>>> +restore_enable:
> >>>>> +     if (needs_quiesce && can_restore_enable) {
> >>>>> +             spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +             sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, =
true);
> >>>>> +             spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +     }
> >>>>> +
> >>>>> +     return ret;
> >>>>
> >>>> For a function that is supposed to just write wfhw into the hardware
> >>>> that is really complicated. Is this really necessary?
> >>>
> >>> There was avoidable complexity here. V9 encodes the channel register
> >>> values during waveform conversion and uses one preparation helper for
> >>> rate protection, quiescing and rollback. The write callback then appl=
ies
> >>> those values, without the redundant private-field validation.
> >>>
> >>> I kept the pending-period handshake and the checks for whether an upd=
ate
> >>> can safely run live. Clock, prescaler, polarity and bypass transition=
s
> >>> may require stopping the output. After a failed rate change, restarti=
ng
> >>> it also requires restoring the old clock first; otherwise the old
> >>> register values could produce a different waveform.
> >>>
> >>>>> +}
> >>>>> +
> >>>>> +struct sun8i_pwm_rounding {
> >>>>> +     const struct pwm_waveform *requested;
> >>>>> +     struct sun8i_pwm_waveform best;
> >>>>> +     struct pwm_waveform best_wf;
> >>>>> +     u32 current_pair_rate;
> >>>>> +     bool have_best;
> >>>>> +};
> >>>>> +
> >>>>> +static bool
> >>>>> +sun8i_pwm_candidate_is_better(const struct sun8i_pwm_rounding *rou=
nding,
> >>>>> +                           const struct sun8i_pwm_waveform *candid=
ate,
> >>>>> +                           const struct pwm_waveform *candidate_wf=
)
> >>>>> +{
> >>>>> +     const struct pwm_waveform *requested =3D rounding->requested;
> >>>>> +     bool candidate_period_down, best_period_down;
> >>>>> +
> >>>>> +     /* A zero-duty, zero-offset cycle-mode candidate always exist=
s. */
> >>>>> +     if (candidate_wf->duty_length_ns > requested->duty_length_ns =
||
> >>>>> +         candidate_wf->duty_offset_ns > requested->duty_offset_ns)
> >>>>> +             return false;
> >>>>> +
> >>>>> +     if (!rounding->have_best)
> >>>>> +             return true;
> >>>>> +
> >>>>> +     candidate_period_down =3D
> >>>>> +             candidate_wf->period_length_ns <=3D requested->period=
_length_ns;
> >>>>> +     best_period_down =3D
> >>>>> +             rounding->best_wf.period_length_ns <=3D requested->pe=
riod_length_ns;
> >>>>> +     if (candidate_period_down !=3D best_period_down)
> >>>>> +             return candidate_period_down;
> >>>>> +
> >>>>> +     if (candidate_wf->period_length_ns !=3D
> >>>>> +         rounding->best_wf.period_length_ns) {
> >>>>> +             if (candidate_period_down)
> >>>>> +                     return candidate_wf->period_length_ns >
> >>>>> +                            rounding->best_wf.period_length_ns;
> >>>>> +
> >>>>> +             return candidate_wf->period_length_ns <
> >>>>> +                    rounding->best_wf.period_length_ns;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (candidate_wf->duty_length_ns !=3D
> >>>>> +         rounding->best_wf.duty_length_ns)
> >>>>> +             return candidate_wf->duty_length_ns >
> >>>>> +                    rounding->best_wf.duty_length_ns;
> >>>>> +
> >>>>> +     if (candidate_wf->duty_offset_ns !=3D
> >>>>> +         rounding->best_wf.duty_offset_ns)
> >>>>> +             return candidate_wf->duty_offset_ns >
> >>>>> +                    rounding->best_wf.duty_offset_ns;
> >>>>> +
> >>>>> +     /* Avoid a shared pair-rate change when two settings are equi=
valent. */
> >>>>> +     return candidate->pair_rate =3D=3D rounding->current_pair_rat=
e &&
> >>>>> +            rounding->best.pair_rate !=3D rounding->current_pair_r=
ate;
> >>>>> +}
> >>>>> +
> >>>>> +static void
> >>>>> +sun8i_pwm_consider_candidate(struct sun8i_pwm_rounding *rounding,
> >>>>> +                          const struct sun8i_pwm_waveform *candida=
te)
> >>>>> +{
> >>>>> +     struct pwm_waveform candidate_wf;
> >>>>> +
> >>>>> +     sun8i_pwm_waveform_to_ns(candidate, &candidate_wf);
> >>>>> +     if (!sun8i_pwm_candidate_is_better(rounding, candidate,
> >>>>> +                                        &candidate_wf))
> >>>>> +             return;
> >>>>> +
> >>>>> +     rounding->best =3D *candidate;
> >>>>> +     rounding->best_wf =3D candidate_wf;
> >>>>> +     rounding->have_best =3D true;
> >>>>> +}
> >>>>> +
> >>>>> +static void
> >>>>> +sun8i_pwm_consider_normal(struct sun8i_pwm_rounding *rounding, u32=
 pair_rate,
> >>>>> +                       u16 div_k)
> >>>>> +{
> >>>>> +     const struct pwm_waveform *requested =3D rounding->requested;
> >>>>> +     struct sun8i_pwm_waveform candidate =3D {
> >>>>> +             .enabled =3D true,
> >>>>> +             .pair_rate =3D pair_rate,
> >>>>> +             .div_k =3D div_k,
> >>>>> +     };
> >>>>> +     u64 denominator =3D NSEC_PER_SEC * (u64)div_k;
> >>>>> +     u64 duty_ticks, period_ticks;
> >>>>> +     u64 duty_ns =3D requested->duty_length_ns;
> >>>>> +     u64 period_ns =3D requested->period_length_ns;
> >>>>> +     u32 inactive_ticks;
> >>>>> +
> >>>>> +     period_ticks =3D mul_u64_u64_div_u64(period_ns, pair_rate, de=
nominator);
> >>>>> +     period_ticks =3D clamp_t(u64, period_ticks, 1, SUN8I_PWM_PPR_=
PERIOD_MAX);
> >>>>> +     candidate.period_ticks =3D period_ticks;
> >>>>> +     if (candidate.period_ticks > 1 &&
> >>>>> +         sun8i_pwm_ticks_to_ns(candidate.period_ticks, div_k, pair=
_rate) >
> >>>>> +         requested->period_length_ns)
> >>>>> +             candidate.period_ticks--;
> >>>>> +
> >>>>> +     duty_ticks =3D mul_u64_u64_div_u64(duty_ns, pair_rate, denomi=
nator);
> >>>>> +     duty_ticks =3D min_t(u64, duty_ticks, candidate.period_ticks)=
;
> >>>>> +     if (duty_ticks &&
> >>>>> +         sun8i_pwm_ticks_to_ns(duty_ticks, div_k, pair_rate) >
> >>>>> +         requested->duty_length_ns)
> >>>>> +             duty_ticks--;
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Zero active ticks encode either constant level. For a togg=
ling
> >>>>> +      * waveform, active-low mode places the rising edge after the=
 inactive
> >>>>> +      * part, which is the only non-zero offset supported by the h=
ardware.
> >>>>> +      */
> >>>>> +     if (!duty_ticks) {
> >>>>> +             candidate.active_state =3D true;
> >>>>> +             candidate.duty_ticks =3D 0;
> >>>>> +     } else if (duty_ticks =3D=3D candidate.period_ticks) {
> >>>>> +             candidate.active_state =3D false;
> >>>>> +             candidate.duty_ticks =3D 0;
> >>>>> +     } else {
> >>>>> +             inactive_ticks =3D candidate.period_ticks - duty_tick=
s;
> >>>>> +             if (sun8i_pwm_ticks_to_ns(inactive_ticks, div_k, pair=
_rate) <=3D
> >>>>> +                 requested->duty_offset_ns) {
> >>>>> +                     candidate.active_state =3D false;
> >>>>> +                     candidate.duty_ticks =3D inactive_ticks;
> >>>>> +             } else {
> >>>>> +                     candidate.active_state =3D true;
> >>>>> +                     candidate.duty_ticks =3D duty_ticks;
> >>>>> +             }
> >>>>> +     }
> >>>>> +
> >>>>> +     sun8i_pwm_consider_candidate(rounding, &candidate);
> >>>>> +}
> >>>>> +
> >>>>> +static void
> >>>>> +sun8i_pwm_consider_pair_rate(struct sun8i_pwm_rounding *rounding,
> >>>>> +                          u32 pair_rate)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_waveform bypass =3D {
> >>>>> +             .duty_ticks =3D 1,
> >>>>> +             .period_ticks =3D 1,
> >>>>> +             .pair_rate =3D pair_rate,
> >>>>> +             .div_k =3D 1,
> >>>>> +             .enabled =3D true,
> >>>>> +             .active_state =3D true,
> >>>>> +             .bypass_en =3D true,
> >>>>> +     };
> >>>>> +
> >>>>> +     for (unsigned int div_k =3D 1; div_k <=3D 256; div_k++)
> >>>>> +             sun8i_pwm_consider_normal(rounding, pair_rate, div_k)=
;
> >>>>> +
> >>>>> +     sun8i_pwm_consider_candidate(rounding, &bypass);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_round_waveform_tohw(struct pwm_chip *chip,
> >>>>> +                                      struct pwm_device *pwm,
> >>>>> +                                      const struct pwm_waveform *w=
f,
> >>>>> +                                      void *_wfhw)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chi=
p);
> >>>>> +     struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm-=
>hwpwm];
> >>>>> +     struct sun8i_pwm_pair *pair =3D
> >>>>> +             &sun8i_chip->pairs[SUN8I_PWM_PAIR_IDX(pwm->hwpwm)];
> >>>>> +     struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> >>>>> +     struct sun8i_pwm_rounding rounding =3D {
> >>>>> +             .requested =3D wf,
> >>>>> +     };
> >>>>> +     unsigned long current_rate;
> >>>>> +
> >>>>> +     if (!wf->period_length_ns) {
> >>>>> +             *wfhw =3D (struct sun8i_pwm_waveform) {
> >>>>> +                     .enabled =3D false,
> >>>>> +             };
> >>>>> +             return 0;
> >>>>> +     }
> >>>>> +
> >>>>> +     current_rate =3D clk_get_rate(chan->pair_clk);
> >>>>> +     if (!current_rate || current_rate > U32_MAX)
> >>>>> +             return -ERANGE;
> >>>>> +     rounding.current_pair_rate =3D current_rate;
> >>>>> +
> >>>>> +     if (sun8i_pwm_pair_rate_constrained(sun8i_chip, pwm->hwpwm)) =
{
> >>>>> +             sun8i_pwm_consider_pair_rate(&rounding, current_rate)=
;
> >>>>
> >>>> These consider functions make an over-engineered impression on me. O=
ver
> >>>> all I have the impression this driver is more complicated than
> >>>> necessary. I didn't recheck on Richard's previous iteration, but tha=
t
> >>>> seemed simpler (read: better) to me.
> >>>
> >>> The fixed-rate/divider conversion is now a pure helper, and candidate
> >>> comparison and selection use one function. The redundant corrective
> >>> rounding steps are gone too.
> >>>
> >>> I retained the bounded search across parents, dividers and bypass so =
the
> >>> choice follows the period, duty and offset ordering rather than a
> >>> preferred-parent heuristic. It still handles inverted waveforms,
> >>> constant levels and the 65536-tick period boundary.
> >>>
> >>>>> +     } else {
> >>>>> +             for (unsigned int parent_idx =3D 0;
> >>>>> +                  parent_idx < clk_hw_get_num_parents(pair->hw);
> >>>>> +                  parent_idx++) {
> >>>>> +                     struct clk_hw *parent;
> >>>>> +                     unsigned long parent_rate;
> >>>>> +
> >>>>> +                     parent =3D clk_hw_get_parent_by_index(pair->h=
w, parent_idx);
> >>>>> +                     if (!parent)
> >>>>> +                             continue;
> >>>>> +                     parent_rate =3D clk_hw_get_rate(parent);
> >>>>> +                     if (!parent_rate)
> >>>>> +                             continue;
> >>>>> +
> >>>>> +                     for (unsigned int i =3D 0; sun8i_pwm_div_m_ta=
ble[i].div;
> >>>>> +                          i++) {
> >>>>> +                             u16 div_m =3D sun8i_pwm_div_m_table[i=
].div;
> >>>>> +                             u64 pair_rate;
> >>>>> +
> >>>>> +                             pair_rate =3D DIV_ROUND_UP_ULL(parent=
_rate, div_m);
> >>>>> +                             if (!pair_rate || pair_rate > U32_MAX=
)
> >>>>> +                                     continue;
> >>>>> +                             sun8i_pwm_consider_pair_rate(&roundin=
g, pair_rate);
> >>>>> +                     }
> >>>>> +             }
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!rounding.have_best)
> >>>>> +             return -EINVAL;
> >>>>> +     *wfhw =3D rounding.best;
> >>>>> +
> >>>>> +     dev_dbg(pwmchip_parent(chip),
> >>>>> +             "pwm#%u: %llu/%llu [+%llu] -> pair-rate=3D%u, div-k=
=3D%u, period=3D%u, duty=3D%u, bypass=3D%u, active-high=3D%u\n",
> >>>>> +             pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns,
> >>>>> +             wf->duty_offset_ns, wfhw->pair_rate, wfhw->div_k,
> >>>>> +             wfhw->period_ticks, wfhw->duty_ticks, wfhw->bypass_en=
,
> >>>>> +             wfhw->active_state);
> >>>>> +
> >>>>> +     return rounding.best_wf.period_length_ns > wf->period_length_=
ns;
> >>>>> +}
> >>>>> +
> >>>>> +static const struct pwm_ops sun8i_pwm_ops =3D {
> >>>>> +     .request =3D sun8i_pwm_request,
> >>>>> +     .free =3D sun8i_pwm_free,
> >>>>> +     .sizeof_wfhw =3D sizeof(struct sun8i_pwm_waveform),
> >>>>> +     .round_waveform_tohw =3D sun8i_pwm_round_waveform_tohw,
> >>>>> +     .round_waveform_fromhw =3D sun8i_pwm_round_waveform_fromhw,
> >>>>> +     .read_waveform =3D sun8i_pwm_read_waveform,
> >>>>> +     .write_waveform =3D sun8i_pwm_write_waveform,
> >>>>> +};
> >>>>> +
> >>>>> +/* Register the shared mux, gate and /div_m clock for each channel=
 pair. */
> >>>>> +static int sun8i_pwm_register_pair_clocks(struct device *dev,
> >>>>> +                                       struct sun8i_pwm_chip *sun8=
i_chip)
> >>>>> +{
> >>>>> +     static const struct clk_parent_data parent_data[] =3D {
> >>>>> +             { .index =3D 0 },
> >>>>> +             { .index =3D 1 },
> >>>>> +     };
> >>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npw=
m, 2);
> >>>>> +
> >>>>> +     for (unsigned int i =3D 0; i < num_pairs; i++) {
> >>>>> +             struct sun8i_pwm_pair *pair =3D &sun8i_chip->pairs[i]=
;
> >>>>> +             void __iomem *reg =3D sun8i_chip->base + SUN8I_PWM_PC=
CR(i);
> >>>>> +             struct clk *pair_clk;
> >>>>> +             const char *name;
> >>>>> +             int ret;
> >>>>> +
> >>>>> +             name =3D devm_kasprintf(dev, GFP_KERNEL,
> >>>>> +                                   "%s#pwm-clk-src%u%u", dev_name(=
dev),
> >>>>> +                                    i * 2, i * 2 + 1);
> >>>>> +             if (!name)
> >>>>> +                     return -ENOMEM;
> >>>>> +
> >>>>> +             pair->mux.reg =3D reg;
> >>>>> +             pair->mux.shift =3D SUN8I_PWM_PCCR_SRC_SHIFT;
> >>>>> +             pair->mux.mask =3D SUN8I_PWM_PCCR_SRC_MASK;
> >>>>> +             pair->mux.flags =3D CLK_MUX_ROUND_CLOSEST;
> >>>>> +             pair->mux.lock =3D &sun8i_chip->lock;
> >>>>> +
> >>>>> +             pair->chip =3D sun8i_chip;
> >>>>> +             pair->index =3D i;
> >>>>> +
> >>>>> +             pair->divider.reg =3D reg;
> >>>>> +             pair->divider.shift =3D SUN8I_PWM_PCCR_DIV_M_SHIFT;
> >>>>> +             pair->divider.width =3D SUN8I_PWM_PCCR_DIV_M_WIDTH;
> >>>>> +             pair->divider.table =3D sun8i_pwm_div_m_table;
> >>>>> +             pair->divider.lock =3D &sun8i_chip->lock;
> >>>>> +
> >>>>> +             pair->hw =3D devm_clk_hw_register_composite_pdata(dev=
, name,
> >>>>> +                                                             paren=
t_data,
> >>>>> +                                                             ARRAY=
_SIZE(parent_data),
> >>>>> +                     &pair->mux.hw, &clk_mux_ops,
> >>>>> +                     &pair->divider.hw, &clk_divider_ops,
> >>>>> +                     &pair->gate_hw, &sun8i_pwm_pair_gate_ops, 0);
> >>>>> +             if (IS_ERR(pair->hw))
> >>>>> +                     return dev_err_probe(dev, PTR_ERR(pair->hw),
> >>>>> +                                          "Failed to register pair=
 %u clock\n", i);
> >>>>> +
> >>>>> +             pair_clk =3D devm_clk_hw_get_clk(dev, pair->hw, NULL)=
;
> >>>>> +             if (IS_ERR(pair_clk))
> >>>>> +                     return dev_err_probe(dev, PTR_ERR(pair_clk),
> >>>>> +                                          "Failed to get pair %u c=
lock\n", i);
> >>>>> +
> >>>>> +             pair->rate_nb.notifier_call =3D sun8i_pwm_pair_rate_n=
otifier;
> >>>>> +             ret =3D devm_clk_notifier_register(dev, pair_clk, &pa=
ir->rate_nb);
> >>>>> +             if (ret)
> >>>>> +                     return dev_err_probe(dev, ret,
> >>>>> +                                          "Failed to protect pair =
%u clock rate\n", i);
> >>>>> +     }
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +/* Register a pair-clock consumer and the bypass clock for each ch=
annel. */
> >>>>> +static int sun8i_pwm_register_channel_clocks(struct device *dev,
> >>>>> +                                          struct sun8i_pwm_chip *s=
un8i_chip)
> >>>>> +{
> >>>>> +     for (unsigned int i =3D 0; i < sun8i_chip->data->npwm; i++) {
> >>>>> +             struct sun8i_pwm_channel *chan =3D &sun8i_chip->chann=
els[i];
> >>>>> +             struct clk_hw *parent =3D sun8i_chip->pairs[SUN8I_PWM=
_PAIR_IDX(i)].hw;
> >>>>> +             struct clk_parent_data parent_data =3D { .hw =3D pare=
nt };
> >>>>> +             struct clk_init_data init =3D {};
> >>>>> +             const char *name;
> >>>>> +             int ret;
> >>>>> +
> >>>>> +             /* Separate handles let CCF arbitrate sibling rate ex=
clusivity. */
> >>>>> +             chan->pair_clk =3D devm_clk_hw_get_clk(dev, parent, N=
ULL);
> >>>>> +             if (IS_ERR(chan->pair_clk))
> >>>>> +                     return dev_err_probe(dev, PTR_ERR(chan->pair_=
clk),
> >>>>> +                                          "Failed to get pair cloc=
k for PWM %u\n", i);
> >>>>> +
> >>>>> +             name =3D devm_kasprintf(dev, GFP_KERNEL, "%s#pwm-bypa=
ss%u",
> >>>>> +                                   dev_name(dev), i);
> >>>>> +             if (!name)
> >>>>> +                     return -ENOMEM;
> >>>>> +
> >>>>> +             chan->bypass.chip =3D sun8i_chip;
> >>>>> +             chan->bypass.index =3D i;
> >>>>> +             init.name =3D name;
> >>>>> +             init.ops =3D &sun8i_pwm_bypass_ops;
> >>>>> +             init.parent_data =3D &parent_data;
> >>>>> +             init.num_parents =3D 1;
> >>>>> +             /* Keep the shared pair rate stable for the prepared =
lifetime. */
> >>>>> +             init.flags =3D CLK_SET_RATE_PARENT | CLK_SET_RATE_GAT=
E;
> >>>>> +             chan->bypass.hw.init =3D &init;
> >>>>> +
> >>>>> +             ret =3D devm_clk_hw_register(dev, &chan->bypass.hw);
> >>>>> +             if (ret)
> >>>>> +                     return dev_err_probe(dev, ret,
> >>>>> +                                          "Failed to register bypa=
ss clock %u\n", i);
> >>>>> +
> >>>>> +             sun8i_chip->hw_data->hws[i] =3D &chan->bypass.hw;
> >>>>> +     }
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +/*
> >>>>> + * A disabled pair gate makes any set PER bits ineffective. Clear =
those stale
> >>>>> + * enables before a clock consumer can turn the shared gate on and=
 expose an
> >>>>> + * unrequested output.
> >>>>> + */
> >>>>> +static void
> >>>>> +sun8i_pwm_sanitize_disabled_pairs(struct sun8i_pwm_chip *sun8i_chi=
p)
> >>>>> +{
> >>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npw=
m, 2);
> >>>>> +     unsigned long flags;
> >>>>> +     u32 per;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>> +             unsigned int first =3D pair * 2;
> >>>>> +             u32 pccr;
> >>>>> +
> >>>>> +             pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(p=
air));
> >>>>> +             if (pccr & SUN8I_PWM_PCCR_GATE)
> >>>>> +                     continue;
> >>>>> +
> >>>>> +             per &=3D ~SUN8I_PWM_ENABLE(first);
> >>>>> +             pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first));
> >>>>> +             if (first + 1 < sun8i_chip->data->npwm) {
> >>>>> +                     per &=3D ~SUN8I_PWM_ENABLE(first + 1);
> >>>>> +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(firs=
t + 1));
> >>>>> +             }
> >>>>> +             sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pai=
r));
> >>>>> +     }
> >>>>> +     sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +}
> >>>>> +
> >>>>> +/*
> >>>>> + * Keep firmware-active outputs running until all declared consume=
rs have had
> >>>>> + * a chance to claim them. Once the driver core calls sync_state()=
, any channel
> >>>>> + * which still has no PWM or clock owner can be stopped.
> >>>>
> >>>> Never saw that callback before, I hesitate to like it. The idea is t=
o
> >>>> disable the PWMs if there is no consumer after boot-up? If this is
> >>>> considered a good idea, I'd prefer to do that at the pwm core level =
for
> >>>> all drivers/devices in the same way.
> >>>
> >>> Removed sync_state() and the driver-local unclaimed-output shutdown
> >>> policy. V9 leaves firmware-active outputs running until a consumer
> >>> changes them, while retaining the hardware-enable checks which protec=
t
> >>> their shared gate and rate.
> >>>
> >>>>> + */
> >>>>> +static void sun8i_pwm_sync_state(struct device *dev)
> >>>>> +{
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip =3D dev_get_drvdata(dev);
> >>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npw=
m, 2);
> >>>>> +     unsigned long empty_pairs =3D 0;
> >>>>> +     unsigned long flags;
> >>>>> +     u32 active, per, unclaimed =3D 0;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&sun8i_chip->lock, flags);
> >>>>> +     per =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> >>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>> +             u32 pair_mask =3D sun8i_pwm_pair_enable_mask(sun8i_ch=
ip, pair);
> >>>>> +             u32 owner_mask;
> >>>>> +             u32 pdzcr;
> >>>>> +
> >>>>> +             owner_mask =3D sun8i_pwm_pair_owner_mask_locked(sun8i=
_chip, pair);
> >>>>> +             pdzcr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR=
(pair));
> >>>>> +             /* Dead-zone mode couples both outputs into one wavef=
orm. */
> >>>>> +             if ((pdzcr & SUN8I_PWM_PDZCR_ENABLE) &&
> >>>>> +                 (per & owner_mask))
> >>>>> +                     continue;
> >>>>> +
> >>>>> +             unclaimed |=3D pair_mask & ~owner_mask;
> >>>>> +     }
> >>>>> +
> >>>>> +     active =3D per & unclaimed;
> >>>>> +     per &=3D ~unclaimed;
> >>>>> +     sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
> >>>>> +
> >>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>> +             unsigned int first =3D pair * 2;
> >>>>> +             u32 pccr;
> >>>>> +
> >>>>> +             pccr =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(p=
air));
> >>>>> +             if (unclaimed & SUN8I_PWM_ENABLE(first))
> >>>>> +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(firs=
t));
> >>>>> +             if (first + 1 < sun8i_chip->data->npwm &&
> >>>>> +                 unclaimed & SUN8I_PWM_ENABLE(first + 1))
> >>>>> +                     pccr &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(firs=
t + 1));
> >>>>> +             sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pai=
r));
> >>>>> +
> >>>>> +             if (!(per & sun8i_pwm_pair_enable_mask(sun8i_chip, pa=
ir)))
> >>>>> +                     empty_pairs |=3D BIT(pair);
> >>>>> +     }
> >>>>> +     spin_unlock_irqrestore(&sun8i_chip->lock, flags);
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Reconcile empty pair gates through CCF. Taking and droppin=
g a
> >>>>> +      * temporary reference leaves a gate with another CCF user en=
abled, but
> >>>>> +      * disables a firmware-enabled gate whose software count is s=
till zero.
> >>>>> +      */
> >>>>> +     for (unsigned int pair =3D 0; pair < num_pairs; pair++) {
> >>>>> +             struct clk *pair_clk;
> >>>>> +             int ret;
> >>>>> +
> >>>>> +             if (!(empty_pairs & BIT(pair)))
> >>>>> +                     continue;
> >>>>> +
> >>>>> +             pair_clk =3D sun8i_chip->channels[pair * 2].pair_clk;
> >>>>> +             ret =3D clk_prepare_enable(pair_clk);
> >>>>> +             if (ret) {
> >>>>> +                     dev_warn(dev, "Failed to synchronize pair %u =
gate: %pe\n",
> >>>>> +                              pair, ERR_PTR(ret));
> >>>>> +                     continue;
> >>>>> +             }
> >>>>> +             clk_disable_unprepare(pair_clk);
> >>>>> +     }
> >>>>> +
> >>>>> +     if (active)
> >>>>> +             dev_dbg(dev, "disabled unclaimed firmware outputs %#x=
\n", active);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_init_clocks(struct device *dev,
> >>>>> +                              struct sun8i_pwm_chip *sun8i_chip)
> >>>>> +{
> >>>>> +     unsigned int num_pairs =3D DIV_ROUND_UP(sun8i_chip->data->npw=
m, 2);
> >>>>> +     size_t hw_data_size;
> >>>>> +     int ret;
> >>>>> +
> >>>>> +     sun8i_chip->pairs =3D devm_kcalloc(dev, num_pairs,
> >>>>> +                                      sizeof(*sun8i_chip->pairs), =
GFP_KERNEL);
> >>>>> +     if (!sun8i_chip->pairs)
> >>>>> +             return -ENOMEM;
> >>>>> +
> >>>>> +     hw_data_size =3D struct_size(sun8i_chip->hw_data, hws,
> >>>>> +                                sun8i_chip->data->npwm);
> >>>>> +     sun8i_chip->hw_data =3D devm_kzalloc(dev, hw_data_size, GFP_K=
ERNEL);
> >>>>> +     if (!sun8i_chip->hw_data)
> >>>>> +             return -ENOMEM;
> >>>>
> >>>> Can you fold these allocations into a single one (that is, have
> >>>> devm_pwmchip_alloc() as only allocation call)? That should give bett=
er
> >>>> cache locality and reduce fragmentation.
> >>>
> >>> The three pair objects and six channel objects are now embedded in th=
e
> >>> private structure allocated by devm_pwmchip_alloc(). The separate one=
cell
> >>> table is gone; clock lookup uses the channel array directly. Clock-na=
me
> >>> allocations and CCF's own allocations remain.
> >>>
> >>>>> +     sun8i_chip->hw_data->num =3D sun8i_chip->data->npwm;
> >>>>> +     sun8i_pwm_sanitize_disabled_pairs(sun8i_chip);
> >>>>> +
> >>>>> +     ret =3D sun8i_pwm_register_pair_clocks(dev, sun8i_chip);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     return sun8i_pwm_register_channel_clocks(dev, sun8i_chip);
> >>>>> +}
> >>>>> +
> >>>>> +static int sun8i_pwm_probe(struct platform_device *pdev)
> >>>>> +{
> >>>>> +     const struct sun8i_pwm_data *data;
> >>>>> +     struct device *dev =3D &pdev->dev;
> >>>>> +     struct sun8i_pwm_chip *sun8i_chip;
> >>>>> +     struct reset_control *rst;
> >>>>> +     struct pwm_chip *chip;
> >>>>> +     int ret;
> >>>>> +
> >>>>> +     data =3D of_device_get_match_data(dev);
> >>>>> +     if (!data)
> >>>>> +             return dev_err_probe(dev, -ENODEV,
> >>>>> +                                  "Missing specific data structure=
\n");
> >>>>> +
> >>>>> +     chip =3D devm_pwmchip_alloc(dev, data->npwm, sizeof(*sun8i_ch=
ip));
> >>>>> +     if (IS_ERR(chip))
> >>>>> +             return dev_err_probe(dev, PTR_ERR(chip),
> >>>>> +                                  "Failed to allocate pwmchip\n");
> >>>>> +
> >>>>> +     sun8i_chip =3D sun8i_pwm_from_chip(chip);
> >>>>> +     sun8i_chip->data =3D data;
> >>>>> +     spin_lock_init(&sun8i_chip->lock);
> >>>>> +     sun8i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> >>>>> +     if (IS_ERR(sun8i_chip->base))
> >>>>> +             return dev_err_probe(dev, PTR_ERR(sun8i_chip->base),
> >>>>> +                                  "Failed to get PWM base address\=
n");
> >>>>> +
> >>>>> +     sun8i_chip->bus_clk =3D devm_clk_get_enabled(dev, "bus");
> >>>>> +     if (IS_ERR(sun8i_chip->bus_clk))
> >>>>> +             return dev_err_probe(dev, PTR_ERR(sun8i_chip->bus_clk=
),
> >>>>> +                                  "Failed to get bus clock\n");
> >>>>> +
> >>>>> +     rst =3D devm_reset_control_get_shared_deasserted(dev, NULL);
> >>>>> +     if (IS_ERR(rst))
> >>>>> +             return dev_err_probe(dev, PTR_ERR(rst),
> >>>>> +                                  "Failed to get reset control\n")=
;
> >>>>> +
> >>>>> +     sun8i_chip->channels =3D devm_kcalloc(dev, data->npwm,
> >>>>> +                                         sizeof(*sun8i_chip->chann=
els),
> >>>>> +                                         GFP_KERNEL);
> >>>>> +     if (!sun8i_chip->channels)
> >>>>> +             return dev_err_probe(dev, -ENOMEM,
> >>>>> +                                  "Failed to allocate %d channels =
array\n",
> >>>>> +                                  data->npwm);
> >>>>> +
> >>>>> +     chip->ops =3D &sun8i_pwm_ops;
> >>>>> +
> >>>>> +     ret =3D sun8i_pwm_init_clocks(dev, sun8i_chip);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_ge=
t,
> >>>>> +                                       sun8i_chip->hw_data);
> >>>>> +     if (ret)
> >>>>> +             return dev_err_probe(dev, ret, "Failed to add HW cloc=
k provider\n");
> >>>>> +
> >>>>> +     ret =3D devm_pwmchip_add(dev, chip);
> >>>>> +     if (ret < 0)
> >>>>> +             return dev_err_probe(dev, ret, "Failed to add PWM chi=
p\n");
> >>>>> +
> >>>>> +     platform_set_drvdata(pdev, sun8i_chip);
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static const struct sun8i_pwm_data sun50i_h616_pwm_data =3D {
> >>>>> +     .npwm =3D 6,
> >>>>
> >>>> Are there new variants of that hardware already in the pipeline and
> >>>> these are known to differ by npwm only? If not, please hardcode that=
 6,
> >>>> or use a dt property (`npwms =3D <6>`). There is no need to do devic=
e
> >>>> variant handling if there is only a single variant.
> >>>
> >>> Removed the single-variant match data and fixed the topology at six
> >>> channels. No npwms property is added.
> >>>
> >>>>
> >>>>> +};
> >>>>> +
> >>>>> +static const struct of_device_id sun8i_pwm_dt_ids[] =3D {
> >>>>> +     {
> >>>>> +             .compatible =3D "allwinner,sun50i-h616-pwm",
> >>>>> +             .data =3D &sun50i_h616_pwm_data,
> >>>>> +     }, {
> >>>>> +             /* sentinel */
> >>>>> +     }
> >>>>> +};
> >>>>> +MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
> >>>>> +
> >>>>> +static struct platform_driver sun8i_pwm_driver =3D {
> >>>>> +     .driver =3D {
> >>>>> +             .name =3D "sun8i-pwm",
> >>>>> +             .of_match_table =3D sun8i_pwm_dt_ids,
> >>>>> +             .sync_state =3D sun8i_pwm_sync_state,
> >>>>> +     },
> >>>>> +     .probe =3D sun8i_pwm_probe,
> >>>>> +};
> >>>>> +module_platform_driver(sun8i_pwm_driver);
> >>>>> +
> >>>>> +MODULE_AUTHOR("Richard Genoud <richard.genoud@bootlin.com>");
> >>>>> +MODULE_DESCRIPTION("Allwinner sun8i PWM driver");
> >>>>> +MODULE_LICENSE("GPL");
> >>>>>
> >>>>> --
> >>>>> 2.53.0
> >>>>>
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
