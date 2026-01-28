Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1112290D81
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603592; cv=none; b=fzovczxu3HFudgwJKpw1luHFL5k4TEI3rcs6OOqBqfJRHMCjLxZYYOmcffHpM0+juaP59v3+FrLfKf4iTar7ksI+nm5z5KxDdHVqHBtsi+KFL/OiArzIkYcL5ht/MR9v2uUofTzOM0m/Y0ChBC9/Cc+cY7iP9Tks7yL7U+eTae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603592; c=relaxed/simple;
	bh=jmuMIS9wtX/dZfFDJahTmMCs3yg9HN6+ZtD9s0KTwRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOQ0UXaLSRI79qKxX/p2AnqoB2ubPPtixiWNSsI4B8y4JhGxYG4ndkeA4M6HSqma7r6JDIUmji9xT6IiBO9hWqq1SIWuXrTT/6DmWRQcc62a82RMDIpBW52WPhETpO/JtTjK+p5LRwPduRg4psJGd6qVbvexaB9KzZ5yuxicRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1YyseJn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1YyseJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF0FC4CEF1
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603591;
	bh=jmuMIS9wtX/dZfFDJahTmMCs3yg9HN6+ZtD9s0KTwRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G1YyseJny3uvkryklZtQjbMt1Vz+oheZYebYiLCFR+FO9avv4ER7I6vpsW4VEQLDk
	 K04NBuyTqEstOr5DioJ9zLZJw8Jbm5WEhbYNNf1hZih5Q5EOBrCusQIIhropu2YPB8
	 TnEbIY/uXU9ZA6BWJsnheRNxRi6JsN9S4ZJH3oP8Tnyeu52AmtngGmjMR8YcmoGfG2
	 fPeMoITbsKrnvcz78b3YqIA2dUPMDCOl8Eku8xOOhe27hwUvRyyV3WqaQTo2mYu7ET
	 jMYbEiCHL5eqZglXUzNhV+Pfpz9yAPN+yXeNuVhhzSZ6gzedw6GY7oNv2NUe3rC4xd
	 FcdJkuKxrMY4Q==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6446c924f9eso5920985d50.1
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 04:33:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeG151G92iSQWOOkPp22Okr2kjh9/TYhc7twP4JEtqZMG0osYiG9peXHlqkwH/GOk54RzBzzDORvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgALKZEsL33e6T4sx/M8c4yU1yJ8/wDtIodVyzMAxEb1/7euu
	FDdrWyWnCFlZcgIWQs0SBA5QlLyRr1jeicjv9uByzeRO2rcSaw6sMDftgTgKoIGRKxTtxn022eN
	CuOzqPhjcoAxa+nWB2zxpiX3EaJcwFmM=
X-Received: by 2002:a05:690e:1918:b0:649:4f65:bff9 with SMTP id
 956f58d0204a3-6498fbf9856mr3287591d50.42.1769603590902; Wed, 28 Jan 2026
 04:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128033936.27642-1-eleanor.lin@realtek.com> <20260128033936.27642-6-eleanor.lin@realtek.com>
In-Reply-To: <20260128033936.27642-6-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 28 Jan 2026 13:33:00 +0100
X-Gmail-Original-Message-ID: <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
X-Gm-Features: AZwV_QgfOnd-isQn6MnRkv3cGqrLlmsh0nRuYAlXYLsiWZlNo-_cZBDGdLVdJVw
Message-ID: <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
Subject: Re: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl binding
To: Yu-Chun Lin <eleanor.lin@realtek.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, brgl@kernel.org, 
	james.tai@realtek.com, cy.huang@realtek.com, stanley_chang@realtek.com, 
	tychang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu-Chun,

thanks for your patch!

[Uwe, can you check this a bit down!]

On Wed, Jan 28, 2026 at 4:39=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> From: Tzuyi Chang <tychang@realtek.com>
>
> Add device tree bindings for RTD1625.
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Overall this looks good!

> +      power-source:
> +        description: |
> +          Valid arguments are described as below:
> +          0: power supply of 1.8V
> +          1: power supply of 3.3V
> +        enum: [0, 1]

OK...

> +      slew-rate:
> +        description: |
> +          Valid arguments are described as below:
> +            0: ~1ns falling time
> +            1: ~10ns falling time
> +            2: ~20ns falling time
> +            3: ~30ns falling time
> +        enum: [0, 1, 2, 3]

Slew rate is usually something like volts/second in SI units, I would
expect that this differs depending on which power-source is selected?
I.e. are these values for 1.8V or 3.3V?

> +      realtek,drive-strength-p:
> +        description: |
> +          Some of pins can be driven using the P-MOS and N-MOS transisto=
r to
> +          achieve finer adjustments.

Finer compared to what? Compared to the overall setting for slew-rate or
drive-strength, or both?

> The block-diagram representation is as
> +          follows:
> +                         VDD
> +                          |
> +                      ||--+
> +               +-----o||     P-MOS-FET
> +               |      ||--+
> +          IN --+          +----- out
> +               |      ||--+
> +               +------||     N-MOS-FET
> +                      ||--+
> +                          |
> +                         GND

Nice picture!

> +          The driving strength of the P-MOS/N-MOS transistors impacts th=
e
> +          waveform's rise/fall times. Greater driving strength results i=
n
> +          shorter rise/fall times. Each P-MOS and N-MOS transistor offer=
s
> +          8 configurable levels (0 to 7), with higher values indicating
> +          greater driving strength, contributing to achieving the desire=
d
> +          speed.
> +
> +          The realtek,drive-strength-p is used to control the driving st=
rength
> +          of the P-MOS output.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 7
> +
> +      realtek,drive-strength-n:
> +        description: |
> +          Similar to the realtek,drive-strength-p, the realtek,drive-str=
ength-n
> +          is used to control the driving strength of the N-MOS output.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 7

These two are really interesting. But what do these settings represent?

I would *guess* it represents the number of transistors used, simply,
so 0 means just one P/N transistor is driving and 7 means 8 transistors
are driving.

Can you provide details here?

In this case, maybe we want a generalized property such as
drive-stages-p =3D <n>;
drive-stages-n =3D <n>;

in the generic bindings, if this will appear from more vendors?

> +      realtek,duty-cycle:
> +        description: |
> +          An integer describing the level to adjust output duty cycle,
> +          controlling the proportion of positive and negative waveforms =
in
> +          nanoseconds.
> +          Valid arguments are described as below:
> +          0: 0ns
> +          2: + 0.25ns
> +          3: + 0.5ns
> +          4: -0.25ns
> +          5: -0.5ns
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 2, 3, 4, 5]

This is a bit dubious.

Isn't this one of those cases where you should be using the PWM
bindings, directly in this node? Just slam in #pwm-cells =3D <...> etc,
I think this is what you really want.

Please consult/reference:
Documentation/devicetree/bindings/pwm/pwm.yaml
consumers would not use pinctrl phandles but something like
pwms =3D <&pwm ....>;

It's maybe a bit trixy to use two generic bindings in the
node but it should be just fine.

I don't feel confident mergeing this without Uwe Kleine-K=C3=B6nig's review=
.

> +      realtek,input-voltage:
> +        description: |
> +          Select the input receiver voltage domain for the pin (1.8V or =
3.3V).
> +          This defines the reference for VIH/VIL and must match the exte=
rnal
> +          signal level.
> +
> +          This does not control the output drive voltage, which is handl=
ed by
> +          the standard generic 'power-source' property.
> +
> +          Valid arguments are described as below:
> +          0: 1.8V input logic level
> +          1: 3.3V input logic level
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]

This looks very generic. Can you please just add input-voltage to
pincfg-node.yaml with a custom format and reference that?

> +      realtek,high-vil:
> +        type: boolean
> +        description: |
> +          Select the input receiver with a higher LOW recognition thresh=
old
> +          (VIL) to improve detection for sources with weak pull-down or =
slow
> +          falling edges.

Isn't this supposed to be input-schmitt-microvolt?

Or is this something else than a schmitt trigger?

In either case, try to figure out the typical recognition threshold in micr=
ovolt
and use that, please.

Yours,
Linus Walleij
