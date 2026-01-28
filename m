Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625252EFDBF
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603849; cv=none; b=MiHib4fDjU/DTi7rg1sZomthxonqtujPWvQFHUilPoBpVRMSyCkquATqGFZHK/zOCvns3YZVIp+H4svstaYTrlMbceR6Q8VaXfKRfQv6qdsxL+UHWILYXyP2Hi+yeL8O95COf+78xiasBx0EO3NflkMWYfKLwFRN32c2lQrCn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603849; c=relaxed/simple;
	bh=5iKagQoG/oEsbtdYvkMI2pAkFINdNZh+t/KQ4Y+jPrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhrbnCewGOV3Uynl1FGlBnLbL0ZVcnQyIIjAWnKjd5tMaY/O/hpAETFLxGsAKhW5S45/QQ+G/tw9qDgdH31jWE+p54PPjDrFs1GTuS/MvssAJNaBTRwGAELFw4fNMBNQnUC8UzZw3QuoSUge9RP3GAh8bwiU2V6HQLUeEqZZ7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZojT/YNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZojT/YNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18587C116C6
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603849;
	bh=5iKagQoG/oEsbtdYvkMI2pAkFINdNZh+t/KQ4Y+jPrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZojT/YNYteN5oHgB3+J3cAC3Qz3tOMaRzN3uKtZ0Ed9aK7pRyqroaNjdV3tBwbOjl
	 t8bjOXgFU1mJQ3PtCgRH0NCxgwSn88tcnd0e2BAGHQu+0Eq0D9r/x2Jwv7kZ0rL+ZL
	 rDEzGmsP8Y/rHYsFaGA5e3C/7m73YlldQ+7cK4KsE8CtRIVUwP1i6jvW93BE46CO3J
	 EiNCWIm/uguBXDRX8F7fQs+t1d4MQzJyr91i/OdtAkMoIwWX8SaP7xzeJPA3ZhU+CF
	 STNyDlnxLWOYPdvz7ecuk5xyA7a8Sv7Q3TCid9z1+1Idf3B9i/+oyU2V8k83k2FlKh
	 a67mJLQfqqvNw==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64960418d46so4824818d50.1
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 04:37:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUINmmZ7B7yUs3OvQ3ru4mSMWhzLdWwak8KzHsQ5+DTmmrGA4jZOWsmKbyGlRnvEZbMWxfxDkRxQY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsS92bm129bXPA9LHecq0oyOUAvOIGZv/72CeOrQGmZ5ExSSQ
	+c+ve3hgnbG3q30CTgJUUT+pxpuRF4OvswwzzufH+ubiSpzfxVg69nz6T1DzF36BofLsOg/Awra
	F1eH5vMjJAC/1fvnLPY1GG5SHRHF8rWk=
X-Received: by 2002:a05:690e:d8b:b0:649:412a:dd11 with SMTP id
 956f58d0204a3-6498fc661f9mr3638155d50.74.1769603848484; Wed, 28 Jan 2026
 04:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128033936.27642-1-eleanor.lin@realtek.com> <20260128033936.27642-7-eleanor.lin@realtek.com>
In-Reply-To: <20260128033936.27642-7-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 28 Jan 2026 13:37:16 +0100
X-Gmail-Original-Message-ID: <CAD++jL=W18NLdaPFyYuVa69jn7Drg+webyMz+_MygCON2LcCgQ@mail.gmail.com>
X-Gm-Features: AZwV_Qi546-iD9VCBtnbu7pC4L03yhLn6hfCHqoqvlwF7uC_Tjjq0QcMzdqiDGU
Message-ID: <CAD++jL=W18NLdaPFyYuVa69jn7Drg+webyMz+_MygCON2LcCgQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] pinctrl: realtek: add support for slew rate, input
 voltage and high VIL
To: Yu-Chun Lin <eleanor.lin@realtek.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, brgl@kernel.org, 
	james.tai@realtek.com, cy.huang@realtek.com, stanley_chang@realtek.com, 
	tychang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 4:39=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> From: Tzuyi Chang <tychang@realtek.com>
>
> Add support for configuring slew rate, input voltage level, and high VIL
> mode. This involves updating the pin configuration parsing logic to handl=
e
> PIN_CONFIG_SLEW_RATE and the new custom properties "realtek,input-voltage=
"
> and "realtek,high-vil".
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
(...)

>  static const struct pinconf_generic_params rtd_custom_bindings[] =3D {
>         {"realtek,drive-strength-p", RTD_DRIVE_STRENGH_P, 0},
>         {"realtek,drive-strength-n", RTD_DRIVE_STRENGH_N, 0},
>         {"realtek,duty-cycle", RTD_DUTY_CYCLE, 0},

I see we are already using some dubious custom properties here.

It slipped through my review I guess :/

It doesn't stop us from using standard properties as well if we go
for that for drive-strength-p/n and duty-cycle.

> +       {"realtek,input-voltage", RTD_INPUT_VOLTAGE, 0},
> +       {"realtek,high-vil", RTD_HIGH_VIL, 1},

Let's try to be stricter with these. I think they should be standard
(non realtek,*) properties.

Yours,
Linus Walleij
