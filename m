Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB040B11E
	for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692287; cv=none; b=qnQvlm4uHokS+rMqCyaxNvPX/yhtW57RtJD4xcmw2/RgP6MhklqDnyYx8WTw1qOzC7N/j0x3l9XVmeO/Tfk9b2XFo47DDA6xeRHu+RtSZPkTyGGw6xRiznLB0dDKRYLU4CCDga/Au5Q5XXqcgnrpRGDYQeQYKJgjMd5rn/C6vVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692287; c=relaxed/simple;
	bh=rdlUChRX55vO9PpflsrwyY/Uty0XIuzlPAZzfWduU2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jps2J3C1g9ExvbwY4s+JVfWygmaycrVghqwNQdKI6N78W43vhHFKkg512WbZp45J+p93XhLs5qWW+BJIP1nBXeVoc242q9ozQLmq1/pc7rhFc9zzqqhFqA05/Ms9/9QeKPu346WQ2RsarGMmcdljABUQWo57NBaHYkYECTttsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdobK5P7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdobK5P7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A2A1F00A3F
	for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 07:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692285;
	bh=rdlUChRX55vO9PpflsrwyY/Uty0XIuzlPAZzfWduU2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NdobK5P7ltwmAODtEn59kDPeamBRluZxJnXO/nVVW+l6uDYRYpOdFpC1Qw4NmYNhd
	 lRrOvNmFvZznVWctNMIwMF+LwqUWKEBQOpZh7CcfT6aPbL6ytHNBMsqddT3GJhjojm
	 zwAcHFmsgoCl2aORKVrzGFVEMDl4rkjT2TgD3Y5bhVCLTs+ZBQpXIdasLjuPwBU3Af
	 Lzka/D50/HRcAcwVAvWN3x129nZIkkJamcngZ0yXeGLRkrjEWcm/C5m5mb87xgl6xJ
	 fgfXg+Rd4zfrSge6O6pl/r6ptqmZieogAqn2PCAKxN6rJ3kmb73OniseZhETNNYoul
	 OmUozkBbB2pKg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2a3166398so709503e87.3
        for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 00:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozzR2PebytkBpdXY54Ks3HukrN3p6EpcVhf1/HmMiYssw4pLHyhwEuyrcE61yHnIn4cGcBkni2XbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7/pmyWPVlL45qYtlKWn3vdicO1CzHHTyACG1cgbGhp17zpWp
	e/8B9dP1N7UfDYwF8rhg15Twk8D5KIO5rmCqhRFb19536GkOxQzKXiuElgZeIwrRIUsCc7LY/Ij
	tA0EJoDBsoT1yAS1tWcmHOoPEppMd5gY=
X-Received: by 2002:a05:6512:3b11:b0:5ae:c636:78 with SMTP id
 2adb3069b0e04-5b459194595mr444450e87.53.1786692283880; Fri, 14 Aug 2026
 00:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-apple-m4-initial-devicetrees-v3-0-6bf32d45ad0b@cyberchaos.dev>
 <20260811-apple-m4-initial-devicetrees-v3-9-6bf32d45ad0b@cyberchaos.dev>
In-Reply-To: <20260811-apple-m4-initial-devicetrees-v3-9-6bf32d45ad0b@cyberchaos.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 09:24:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLkRs5m1m3Y3vBfXvxn13i-3cMXhcEWq5ScD-xbN9uta5A@mail.gmail.com>
X-Gm-Features: AcwNN1U4pSEQhXzI6xw99X3FAIiwxI9oO82g146e3gwAfl2evI9yLHdfuJ1SQuA
Message-ID: <CAD++jLkRs5m1m3Y3vBfXvxn13i-3cMXhcEWq5ScD-xbN9uta5A@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] arm64: dts: apple: Add minimal t8132 (M4) device trees
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
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:37=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.de=
v> wrote:

> Added device trees for the following devices:
> - apple,j604 - MacBook Pro (14-inch, M4, 2024)
> - apple,j623 - iMac (24-inch, 2x USB-C, M4, 2024)
> - apple,j624 - iMac (24-inch, 4x USB-C, M4, 2024)
> - apple,j713 - MacBook Air (13-inch, M4, 2025)
> - apple,j715 - MacBook Air (15-inch, M4, 2025)
> - apple,j773g - Mac mini (M4, 2024)
>
> The device trees have a minimal set of devices limited to CPU cores,
> interrupt controller, power states, watchdog, serial, pin controller,
> i2c and framebuffer.
> The device trees for the notebooks add a PWM controller for the keyboard
> LED illumination.
>
> Using the macOS 26.6 iBoot/firmware, the Mac mini reliably boots on a
> single core using the stock kernel.
> Booting with smp requires avoiding the wfi and wfit instructions
> in the idle loop and `delay()` respectively, since those instructions
> cause a loss of architectural state on the secondary cores, and even
> then boot is unreliable.
>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
