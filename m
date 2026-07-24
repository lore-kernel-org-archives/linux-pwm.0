Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF33C4B72;
	Fri, 24 Jul 2026 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882125; cv=none; b=l3bYTuJRyKgn1taHKU8FxJRieVlyaypgHzpvm0g/gGIO4aL6BT/hZcuc4QcHRJ2FcJGE4+Z+eeSQgV5ZztV6Xvhy6ypvMDBjFaRXgJayWwiia6D6tavyZls9j/+xZ2npXCyBrtBJj1l5p5C8aDdcOo9Qz197g1UgSHfTefhvp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882125; c=relaxed/simple;
	bh=upBiiy5NzC3Xhhu+vyNzwd8kJvhn9iglo3gXB8DGRIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCM4sAE7V1kf/T3yBqiPt27zWBVrtROZAYHHD+blFox4/2ELU4YhCY8Le1jp2HX2UR2hOmInveR9GY/gra5jftXGIPMaGlLwxyp5/FDZOT6DjSLPxnB6sJT6hDWhnHIIoRKeDwzSFEZbXu0AZ1H4l9dOJ8c64s2Q4Gw2zby8Q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUzv0Qi7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUzv0Qi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFCA1F000E9;
	Fri, 24 Jul 2026 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784882121;
	bh=EGHkNmdIUJTnGY5kQs+2/koc4PF6LbOKExGntGGOUi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QUzv0Qi7q6ToCuJBruaPjk22lXt1e/6GUM3Q3WX4MKykwITGIeH5N3kh6fwqB2F4g
	 tgm3IaUS0qH5ihRrIts7HGLiD6A1XCpmTeLhFHbV/b7q0T9iK4tAr8wJ589a2SVkuI
	 o1YJAfzFm8r/dJFmtxKRu1CeQG64gwc/5z417Ks+wUVtUDubIrOsB4CAqzjXajJCLv
	 zzXTTca2ghuC0HS54QM+u6j1qojeOiRrzQtT4fjjzihs45O6ptu0f3hlc0KOoQFZRF
	 6oed2e21WPd9qyko19AqZujoJVNWMZoJ6M2ffncch81lULF8zbClLTtlDS0/I8q1Ik
	 LKyn6efC3oyFw==
Date: Fri, 24 Jul 2026 10:35:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Message-ID: <20260724-fine-pretty-chipmunk-ffb3af@quoll>
References: <20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com>
 <20260723-axiado-ax3000-pwm-v2-1-22002f0b281d@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-axiado-ax3000-pwm-v2-1-22002f0b281d@axiado.com>

On Thu, Jul 23, 2026 at 02:32:18AM -0700, Petar Stepanovic wrote:
> The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
> used to generate configurable PWM output signals.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
>  .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 51 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 ++++
>  2 files changed, 59 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

