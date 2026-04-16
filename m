Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4030EF9B;
	Thu, 16 Apr 2026 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326264; cv=none; b=S2AtarRu8NIhPzpDw+c2tLybfzTcsmZcJQbE8f3gdaDchHoANbVi33foiUfVF5jm6nT4RZ9W+I2i/6BsB8uN3WmzfE7ec+l7HK3Hi8y5QS/Nae2CQDlfLeF0pM/+nwcoDxiN5kBuuJb5z0Ea1fD7FyguoW8UWMYxijN2OXnuDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326264; c=relaxed/simple;
	bh=PkXMUSfNt05PGTT38T88UWe63KprqzcvxVx4oYeo77Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie0lhZ3qWjVOwxTj+J9WvQJGN696zc9MSji2cJdVBhvt+Fe7FtiHOv09QHtyxWY0Fn0Soq5MstggRjnddGJUiwxGgpGHIFfKAA6ohQYxoWtAPafGMAUQ0IzOZMx4JMuT7+cr1xLyeL0PiHP0LKLPtBa+/axbRxeCjf3Ar+iyURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M0udllnP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M0udllnP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 367C31A32F3;
	Thu, 16 Apr 2026 07:57:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0AEF75FDEB;
	Thu, 16 Apr 2026 07:57:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC9FB10459AF6;
	Thu, 16 Apr 2026 09:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776326260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wDw1aA0aJGL5LVw4zkko2JKL4HHId3Bi3Out6Lm4kEs=;
	b=M0udllnPe/Q05WsEcZoNNjkjkms1oP8gEzoT+kTRbsnB3G+xO7wJC8G82V8NOMQ7XTjqDR
	hl9ME7re9eBX6y0YUJp6YzSi3z2MuLHtzG51zeADDzJu98xrahg7l/uFMHMNPy0Wi1VLYD
	3SGPAU3zNltVXqPG6gDcVn8saRrwdG9/YJg8DzrJWmA8PrcAjD/7n3vgYfKGhHMtexwCgt
	2BooONaf+eB9JdAS4kQ5BQ5FhIJtAsOzYgcevff94hwkcUZSbXbegLHcoIkFYyznIbQjlQ
	BjUy0AqcvXmtWzEtXLW5j7vZk8BYCR8QYRRm0dVcNsH88fSogZs8Advp6ozidA==
Message-ID: <2721356a-e905-4074-a5c5-025f18b8fb27@bootlin.com>
Date: Thu, 16 Apr 2026 09:57:37 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] pwm: sun50i: Add H616 PWM support
To: bigunclemax@gmail.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, joao@schimsalabim.eu, jstultz@google.com,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-sunxi@lists.linux.dev, p.zabel@pengutronix.de, paulk@sys-base.io,
 robh@kernel.org, samuel@sholland.org, thomas.petazzoni@bootlin.com,
 u.kleine-koenig@baylibre.com, wens@csie.org
References: <20260305091959.2530374-3-richard.genoud@bootlin.com>
 <20260413123920.2459916-1-bigunclemax@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260413123920.2459916-1-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 13/04/2026 à 14:39, bigunclemax@gmail.com a écrit :
> Hi Richard,
> 
>> +
>> +/* PWM Capture Fall Lock Register */
>> +#define H616_PWM_CFLR(x)		(0x74 + (x) * 0x20)
>> +
>> +#define H616_PWM_PAIR_IDX(chan)		((chan) >> 2)
>> +
> 
> It looks like there's a typo or a mistake in the PAIR_IDX calculation.
> It should be like ((chan) >> 1).
> For example, for the 5th channel the result will be 1, but it should be 2.
Good catch!

I mainly tested with PWM1 as it's the only one easily accessible with a 
scope.

I'll change that in the next iteration.

Thanks!

> 
> Best regards
> Maksim
> 

