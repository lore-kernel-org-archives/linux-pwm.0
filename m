Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC840927A
	for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692246; cv=none; b=iLTAfgqKToMW41Vaa/B6iy7YIXqo0xhpoeDsratvcpFMdAsVuiWlrXSWQHnFGzUWMP1sdA3aIVPgCw0H9jZR+pekw5tlnlATxw5R4I6ncCK/8fFyvOP+d1CMjMo8qwqsJKJSogFxhdFZsK7OpUJuXyNVhNip01n9MpCHr4YNc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692246; c=relaxed/simple;
	bh=BKN9f9mba5XMlPWTAXN8CweS/tPQvXMpBOs+FJWbbU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIgTaU7wfMogTkFbIj0RhyyPt47p4Ppl7HiGAqc6xysDSXLUT2Ji+ezW7Ygz+i8Aff8/FH9AZGib/0o/xwOfiFjRDtn/+UTqwzlRYmL3E4JQaduKF/K6Ld10oKyiyz1XfUX7SE8iM/cROEXHrb4IOxuW/mza/q8ryKP3JEChp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEKqK7FX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEKqK7FX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CA21F00AC4
	for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692245;
	bh=BKN9f9mba5XMlPWTAXN8CweS/tPQvXMpBOs+FJWbbU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iEKqK7FXDAkSNHtkYLTRt3Y4M/r5fWbebShTWtHq/CtTIKjZgSsJlURV1lQXBsUMS
	 8HAaBv/qmXqU3qI0Wonv25AVNbnZAsqq3msF1/iXCkw8IKEX0sAOHmEyYgh/JUwAKl
	 S1TL61mljZPaBTtO8QbEpjyz9OlYukat2h+lQMB55Ol90JBDkiA7qvbcW8BtyC5Lg+
	 jEgOpgobtR9EwZtP+MJwLs5r8RSd8JPuZRnpcp4wgqWo3VSYH9ZSxlc6QudcCS5tUb
	 ImAo7qG5qhuMkHHevXOr9raKXy4jOYioQiqSTYvHBtGwSfdo81v86jJ8DXevjtrAiB
	 bf7wuJB5xncOQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so895061e87.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 00:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqOUZwawNeaKfiv3+2E8i7SUkmonuE0EK38MUfd29ZTo6WZyS60mcR7eMn1uQmtP+mnTZZhJYvrx2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDl7uNR4+VneHh/b2jX1EA6oihe9D7+aWN68Zb8TR6NWg829B
	yU/Nj7ufAkpd5PzhrjnAbQZJzg5PAj7QHvhWikl2ArZSrer+k3P97593dMX+WuG0eEfxIE/bUph
	9BQsl3ovESjKJurR5qRn2EBUbxlJCZSE=
X-Received: by 2002:a05:6512:b93:b0:5b2:d7f2:90af with SMTP id
 2adb3069b0e04-5b4591417a0mr459623e87.37.1786692243871; Fri, 14 Aug 2026
 00:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-apple-m4-initial-devicetrees-v3-0-6bf32d45ad0b@cyberchaos.dev>
 <20260811-apple-m4-initial-devicetrees-v3-1-6bf32d45ad0b@cyberchaos.dev>
In-Reply-To: <20260811-apple-m4-initial-devicetrees-v3-1-6bf32d45ad0b@cyberchaos.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 09:23:50 +0200
X-Gmail-Original-Message-ID: <CAD++jLkf=Ko-S-iPOt7toDRBb0HAEiAZMKXOTkD2sBdt31JWbA@mail.gmail.com>
X-Gm-Features: AcwNN1WiSU-hYtd-LW1Xs-Nm42vxr7uIUwiaDPkA7srTL7iPWg9d8CwHinkdzg4
Message-ID: <CAD++jLkf=Ko-S-iPOt7toDRBb0HAEiAZMKXOTkD2sBdt31JWbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: arm: cpus: Add Apple M4 CPU core compatibles
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Hector Martin <marcan@marcan.st>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:37=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.de=
v> wrote:

> The core types of the M4 SoC no longer carry individual codenames.
> Apple's device trees re-use the 'everest' and 'sawtooth' codenames from
> the M3 generation for all later cores.
>
> Instead, we use a combination of the SoC's codename ('Donan') and the
> type of core ('e' and 'p' for the efficiency and performance cores
> respectively) as compatible for these cores.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
