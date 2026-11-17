Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910197;
	b=IIxFKs4Xm5uQAT0DG1mpMtfERqkAsTVpc0uotyjZTV1pLZKKdc38d83ThFv4HQ1jGOBk
	 OvZ+p/SD7UXzhl3ROlmSimLl0dXqz5jXG/jLGpqSmVH6rKCycP8I6ykJP5UmqTwRGlyTy
	 RnrmUuijy/4Jdh7MPSaDcvvoyX3zzLPpmD45NzmQbJ/8rA85//JzLx4hMzQUCR/IvMVVs
	 Dj3KjBIcTZa4IuH6Y0/F4QuUSN4axg3WcYlv7ehPTeAIyzqV9v779STy/NmHvnHDIokfn
	 Mxc++sNHMVA8oSDHU36MuOEueGcKWEapBmOfie39hr9sFJHqidSECZKixpocl2aLyOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910197;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Zijtj8oRnUhmq8nJwvW4RuvRSCE2yvzPezhEDKGNnBs=;
	b=x85LkAYj9UI8OdXdSHR0E2tQEVv/hIRmjts+m9swDYmVoJW9mQ4RwM732eS67aVArE4F
	 S+Zq5o7oXIX/NA9fCD7vSjwVxHG2KOtLvbGAyMhaORHR5xnU+YC8JKdKQnpwy9NS+Tidi
	 HXw2ArVV69kzarFiPJX6l0FLzbdWGTKQ6eP/QLIZscE/udkw8/ZEPtZb8MEYj1LOi43kA
	 dbmB9QPK/0uJHoXWusjmHFVXzns5xx7iZ8W3wNAdbNIFN4C+Y8it18brsVVEX3zkdjJwJ
	 8i7JOAML63PzsafXuWLT1cof037Ebo3GUiJY34RLL0ZemLO8w1mUKOhtcG3CMNatNTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZryeUptg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A74606A323
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZryeUptg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335271F000CE
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910197;
	bh=Zijtj8oRnUhmq8nJwvW4RuvRSCE2yvzPezhEDKGNnBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZryeUptgE+CTRECXG6PaFFIo2ynUQLFGJoEd6SIe0bh6T+R/8Ylgar/c7UC7XvKKC
	 RboUXutefAjs9UYoNbZHAKOaTW5RdZ5zVYtKi0OfrOVqV6O15XplMzPAJsgewCr4HB
	 jYy1L7eKdJ6jhTQiiqJPM67KFcuQlnIrmZewUg0LJp8wECWmle0XH2HTiWC1acvEg3
	 MYnT4y7Fn62BBVq1IiXmI2aahHYNKiTgJnPAsemi0K9G8QGaSJp9BMSiJVdz3A2V/W
	 vjdvoLdHPWv0dWGgHsG+gw8ftu2pno184/1QGkhwvlTsaCs/wqp6SdJ1kK2zoj/VIm
	 ggZq9GRKBJJsA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c126fa1e3aso3482754e87.2
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 02:09:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEX4f/UD47zQ9lQqO62Pw9euRAptDMIy/vCoyEgXn5wzxjQg2JAHlladTMD/Yyl6NUnTdSaR8t8oyg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A2drF6naIixEO63sME8Um3USL906PDRksRX7f0j6cR3qhr2fT
	z5AdHQXQOhb71O4IbWF/+HcpyCszr1zRP029bplVCguYjTw+rwHqPc0XdppUc0xt6GxmbZepbwB
	xDv811v4Hz8cKhlDzGxII+WEW4DocusM=
X-Received: by 2002:a05:6512:3e10:b0:5c0:91e:a95b with SMTP id
 2adb3069b0e04-5c17077e429mr4781706e87.14.1794910195950; Tue, 17 Nov 2026
 02:09:55 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
 <20261106-apple-m5-initial-devicetrees-v3-9-cee55de54b2f@cyberchaos.dev>
In-Reply-To: <20261106-apple-m5-initial-devicetrees-v3-9-cee55de54b2f@cyberchaos.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 11:09:42 +0100
X-Gmail-Original-Message-ID: <CAD++jLmvsXAZwb2ak4vumXqZTPgGNqm=fdgWEgw7VqqzvU83WQ@mail.gmail.com>
X-Gm-Features: Aa3M54oq4YzlnIadSqNmPikBx7uA231ihP8lcXU-Pc_buuhnmKKyHs_C06WfytM
Message-ID: <CAD++jLmvsXAZwb2ak4vumXqZTPgGNqm=fdgWEgw7VqqzvU83WQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] arm64: dts: apple: Add minimal t8142 (M5) device trees
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:24=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.de=
v> wrote:

> Added device trees for the following devices:
> - apple,j704 - MacBook Pro (14-inch, M5, 2026)
> - apple,j813 - MacBook Air (13-inch, M5, 2026)
> - apple,j815 - MacBook Air (15-inch, M5, 2026)
>
> The device trees have a minimal set of devices limited to CPU cores,
> interrupt controller, watchdog, serial, pin controllers, i2c and
> framebuffer.
>
> Boot-tested on j704 with macOS 26.6 iBoot/firmware and the latest m1n1.
>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Looks good!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
