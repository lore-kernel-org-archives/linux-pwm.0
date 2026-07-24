Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A3368D67;
	Fri, 24 Jul 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882199; cv=none; b=MB+he3n5vfky+grmxJ8x0P0/7b9m0DHyVuejOJCes2mgPBZSkYrtYSd4raZb9rw30LU07V7rPna+Rfrh+DPczXOq9D6Ez3aiY4ipHYUvG4nyt/kTjPTt7hAoppw+ye4JfHCPTRgVrvR/8v+gHQYGnnAVJogndOLSQja6OY4h8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882199; c=relaxed/simple;
	bh=m8UNRsnE6QxoJE44u4jBPof7wIUQhsm4IQFa6+rq+sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNT17oOiJ7ldVz8RN35wDNqrRwS9p80CGhuiU9TeistYcmcp+3j9d9cGApP1oIifu+dG/0fDeLUAChr9nT2wZxo5TpjwJCC7WCy0j78VcqVslZJCG+SJt5QpJSRV/k6xfrVqQfTG5oJlQGHgp16F09rwG1JzXpfv27Eaf9f6Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ5YylzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ5YylzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30301F00A3A;
	Fri, 24 Jul 2026 08:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784882190;
	bh=KLuk2iJcxA3riTTDQBpgkGpSWa/TkrAiphpb7ujl2Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DZ5YylzFuI34TQWBrqG9S/l6buNmHuiwq92q3vNhtTVrgzY5F9k1b5KBjBz6HEFyu
	 aqXaip6JUTHGd3pOptfZ7qO1zJN+3QhPRKgWwS0JLJmm+C2pPq7itbEqrndduwRV06
	 i+n0yfdQI1gRz32qXCzprJ+5ALoxu/fbBxg8SDJLFNcLyielM2j/x7xS1AagB0gCdh
	 CgO+tkUcbse0EkFOs1jIF5TVO2ySoggHC4wgYPcVEFJ6TMy2dftX+L1u1vo9EfYqtw
	 bIj+IPccYRz3oKcsgIiV4r9Eu22RdqFCqjsQ7cDV+cOXFd1N386xVzKyil3sRRNqB3
	 QkPAyZ6CCtjAQ==
Date: Fri, 24 Jul 2026 10:36:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: add Axiado AX3000 PWM driver
Message-ID: <20260724-comical-chubby-dragon-9c73ff@quoll>
References: <20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com>
 <20260723-axiado-ax3000-pwm-v2-2-22002f0b281d@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-axiado-ax3000-pwm-v2-2-22002f0b281d@axiado.com>

On Thu, Jul 23, 2026 at 02:32:19AM -0700, Petar Stepanovic wrote:
> +	chip->ops = &axiado_pwm_ops;
> +	chip->atomic = true;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axiado_pwm_match[] = {
> +	{ .compatible = "axiado,ax3000-pwm" },
> +	{ .compatible = "axiado,ax3005-pwm" },

This suggests deviecs are fully compatible, so drop the second entry and
express compatibility (see writing bindings, example schema, DTS101
talk/slides).

Best regards,
Krzysztof

