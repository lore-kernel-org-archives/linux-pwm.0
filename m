Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE434B0E53
	for <linux-pwm@vger.kernel.org>; Wed, 16 Sep 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578914; cv=none; b=f1ailPJlY6z3ZrkL72uC1zWxDSIM5b/IVLlFONe/R7xzglNjWckiq6oe2kh8+mXDsKyD86rwOWwn4kObLEvjX8QCNDjUhNaborOprWTe7DArOBJSk+hFJpR+ORATL0eLrkgPtcwnaSpT7nv0OqAOyajsIrlUnhkRM9n9hQVVNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578914; c=relaxed/simple;
	bh=x+RzZmHnqaIFv/afq4EE1msbYj1HqtHQnuxnErsonnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dByN9E4lGcwSGT9ElqxNr4Q/db/Old4DTbGeEG9sjSmVQNjifgYZlMTCnHty4XaGxDaMtn60VNh8u0vuUH1fKDEpfVCZkHtrK07i9WlX+Z8V9FAUL+ofDDrA2n87WCNA1JeXKB+fRGb+b7Tq4CjDgDcSc9vakTSEZvalLGUNT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJWKyUQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJWKyUQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8741F0089C
	for <linux-pwm@vger.kernel.org>; Wed, 16 Sep 2026 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578911;
	bh=x+RzZmHnqaIFv/afq4EE1msbYj1HqtHQnuxnErsonnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fJWKyUQGkPoGP6Y6CKkbMqnqk0M61nrKSbxnHjagrEGHJbkxh2gmxnq+2sBMXzN1Z
	 Qz2mT0p9yrfu8kVSu40m5cIhXgOSeqCmYnNDCC+rciMkhrLs0p+dcBdoN1vVayVBVt
	 N+d6tLIHjwuKx2KEFKfarXY6aKGGJQr9I6ZxAlXvUMMZLLUY5kv5hwPIysLW2BsVeg
	 MGNEuRRKp8UVTSz51bvHgHX3WwwSqqMl3q7XHvNdY/hy9VyasfbQH6PYP0ppfJjeZb
	 gqM4N2Sy8rxyPTLehUtbIuvkIJakxSI/S6RjBJZmFFESkhSMFGoXksEure1UOiIk8f
	 Gq8jo4oKDZJDg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b76462aae9so924125e87.2
        for <linux-pwm@vger.kernel.org>; Wed, 16 Sep 2026 10:15:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxMss6ougnz6D+2e4ZM/RrP7hyR8i1IVyJPhCxC54kIpLChtUldZVGEKzWpnooovskj6oTyrQc/Qa8=@vger.kernel.org
X-Gm-Message-State: AFuF++kPBjC+XcdRR2tAMxfkd+0aDOuRaT4DaUUmirWAqfwLBYEBm6Li
	JcmUgyJzMYnfYABIycJZLKDunVDRV85fscMPNsMI3+C+KJ6DKYrOzjJ/UVjONO0WXF21YGTWBmu
	ONvVxFAoSol/vkn/P5KuzNqIYdfL8gNA=
X-Received: by 2002:a05:6512:4023:b0:5b8:b419:c8ad with SMTP id
 2adb3069b0e04-5b8b6617917mr991899e87.17.1789578909833; Wed, 16 Sep 2026
 10:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com> <20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:14:57 +0200
X-Gmail-Original-Message-ID: <CAD++jL=PV_BEw6pa=M7dDEMNMg2xfbBESGanXE2sajTav5hPBg@mail.gmail.com>
X-Gm-Features: AcwNN1VY_W0_it0rWdRRWdWtRhIbKagoTA3QAM941QSR0htK7aD0JhAkkSfT2YY
Message-ID: <CAD++jL=PV_BEw6pa=M7dDEMNMg2xfbBESGanXE2sajTav5hPBg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] of: unittest: Test fw_devlink with GPIO nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 4:16=E2=80=AFPM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> Add OF unit tests that call the fw_devlink add_links operation for GPIOs
> routed through nexus maps. Verify that each mapped consumer has exactly
> one link to the final GPIO provider rather than to the nexus.
>
> Also cover direct references and all GPIO property spellings recognized
> by fw_devlink, including the deprecated singular and unprefixed forms.
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
