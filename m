Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804134;
	b=wjz4d7wbEDFhI77Sk5kRCEC6uZaHD1NItXhn9cm5moeSX+AGXie/ciluW9XFjd3ehBIu
	 6/T+NtWhgwvkY7NfiuIPeJNoF8XJ7zJJ5E0095ajYN23Frz+BMCyGQ2/QNyP4cHy2i/d+
	 wo1WVN5S4FTfiZG4HJh82WY4+zeO7w5na+eo9sLQUnZ3KWO7cvNYQUPFS890PzGAlQyz9
	 7+mZGlUunhxbNqVsO0yZ9/rJOwsUxL+IcgNpyx+j8jvoic2g+3BP6oeMD+dnSM06CS12S
	 f5DeI9sx+Nj943cHgOUWwgFCit+LW8dotpcqOHrKuIseBQ0sjGC/h30bQAZNnwtzo0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804134;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=isimDxNSlztO3YEPF/qt1Nhk4IMQdPHrybt3Xy8kD+w=;
	b=4+17pGFLbPEMSwWy9hy3iI6qNQMYoElQ+X4feypxOef1Cnla/ST95PfPyfIZza/vuFp+
	 Qh+SqS7UZrtTJzKd4uLK2QMNeu714sGuAGVJSloO0GxG/LKjYV7D6uTwjS2TjqCJydmYt
	 mff3x6ECwXiIvnUKTBeiOVWeuxy/7dnuU/ptFSCG/ZR9SuXVUib9bBGAJ+ojhIMB5ixfG
	 l08d/inJlqOrDr5Jkg05krgVyv+8i00tdiJzMAO2Xb1vH1JzFtCsSbtBBlt0UoTn7Qdt3
	 ZdNfgFnSIsabdSIj9eneFT3G3YG44lMHFLbBanSeuSB4J9nncgsq+hDHmr1xg3ilPXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6DhnRuS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A349606A326;
	Wed,  4 Nov 2026 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6DhnRuS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B611F000C1;
	Wed,  4 Nov 2026 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804133;
	bh=isimDxNSlztO3YEPF/qt1Nhk4IMQdPHrybt3Xy8kD+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W6DhnRuSWypXbxJXbNQ0EMyk/tuSgRWZxUmxBNPdGJBTJSAwubFgemB5eeOyGblCF
	 8oFvQ48yR3N5W6xAqzi588S2gt9epZt7XMQb09VseekknBdGEfATiQKN2yWU8y9jm9
	 vu2mbneCsNSadfo2ZobEmXqzvJ0M8T7wTKtXZyZxTmwoQJC1rRC2a+nF87EqLRgXaw
	 8VDdasCXqn5dXyquvJ9LquE2oCqmzf0LHbsMs0XSPy1MWvLEkIq6Xfr30Tea3I/fiW
	 h8MM6FVVrvO2LDEeSYnofhzOGVfJMsTAnNdE1WhgIFkUTuA4xFdwcV8nLMQ758HC2H
	 IIdIJy7UDTBig==
Date: Wed, 4 Nov 2026 15:55:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Remove orphan HiSilicon hibvt driver
Message-ID: <20261104-careful-organic-hyrax-faed56@quoll>
References: <20261104145104.950566-1-robh@kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104145104.950566-1-robh@kernel.org>

On Wed, Nov 04, 2026 at 08:51:02AM -0600, Rob Herring (Arm) wrote:
> Remove the HiSilicon hibvt PWM driver as none of the SoCs exist
> upstream. The hi3516cv300 only has pwm, clock and ethernet drivers.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/pwm/pwm-hibvt.txt     |  23 --
>  drivers/pwm/Kconfig                           |  10 -
>  drivers/pwm/Makefile                          |   1 -
>  drivers/pwm/pwm-hibvt.c                       | 285 ------------------
>  4 files changed, 319 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>  delete mode 100644 drivers/pwm/pwm-hibvt.c

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

