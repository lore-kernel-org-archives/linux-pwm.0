Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E73BD224
	for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564250; cv=none; b=ZSpnJnzj53OgTHeUgFUzufR0m7sDlfrRrTqum2UT0noTBb0A5KEhaRJLZ0PzeUTINh/Yoywq69zUksVV++zb4vdKEck/v+RutrJZoQW2bC3zAjQFnHGEKGNgU6erbLC2O00TrMtXisXggfQfH1XF/LDZIFECDUa50tYGzAJUeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564250; c=relaxed/simple;
	bh=pwEE6fibC3x6lQyfDb+v+RGRyll+J5mMBnA1XQCUdSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6oF+F0O9fpeGOiqgb146t4F6WiArEZWroxfS0zEPWj2dvLNYRrw3asAAE4wLyBPyD7rU3yIEnIEt+LSdwpQjGeXlZRmL9dI3APvKRG5GpiXouO6ITEoZyjWudcphNqfEwBog/MjVayHxZF64AcJTFWRzgRfqHrWdrHrlirBMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrkwtfkE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrkwtfkE"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-caf707e3a70so2368105a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784564247; x=1785169047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bgWQqTl41PqRe7SjquS4u/1d/gci4UsHSjvtso+pedQ=;
        b=WrkwtfkEcugP8+LlhTWYVodze2uxUaw4UknXzSbamJHUTLYfT6ffFFgwrMrpibpTX/
         THYIk9X8Qso8qyU+Tv16nEIZtNucu5LvqHtF+/xtc/SBk6rITRnEZ/T+v7sreU53pGz/
         SvKo7r83d3dO0WhZ7mcYvbZrNVqMFevvhAgrTtLBGyjdbSYV61suJp0HzdRRpT7tL4Za
         5IWgod+vPzv7Qs+Ww9ZmFdVJ/4PeHY/K7N4H0W2qnFlmn8xadnghJPvHZjVqKN/n2hA+
         yELhgObUJt4jNayVHkmPivafI2wt4+kBU4abo/jp7QDhIoSDLt+5Zj/mltKVlCWLRfau
         ltCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564247; x=1785169047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgWQqTl41PqRe7SjquS4u/1d/gci4UsHSjvtso+pedQ=;
        b=m0kYxvP92WL1KrzQXPUFhjeFwz4WidFj7EewrLQK414FsZO14bFP54sLIMrGuUxrI2
         MmgLwaESlu9OE5XyJ1L6enC0T7+aKJxAkqLfkNoUpV5uZQLiy0wVQ1VspYH5Ps1blAWV
         KTBzJGSxRTX1U2lrIY8DF8AbjdAl/+aj/3MITut4nCr66/39ThwFLqwtGsSOXeF3d0RG
         Oab9gF31yQ2ZvEWvSWyKGZHcK4oTKKnfcE74fq7KcZL9lcMHBGy9QbLiYviNmayPnSTr
         PjTHrz+fcTFYrT5PQah5rBoMdISGwZpN8XlB4ChLNlzG4PGgG06yKv6TQGVnw+F2Py0o
         Rilw==
X-Forwarded-Encrypted: i=1; AHgh+RoUTWH+Gz2GXQ6LO45llAihS/P5DiysnHg8ikg1HqhNd3DhunzVdyrVJUxoP9Oya15cXX1u9KJ9RFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQ1uoH1m9hSQl+Njy4oV4CrktiL8YB0UmjJC3wlE6WDpTqDNP
	rgvfgk8dajZ5mIgw9F1zlDCaGqEd0VeZt6++7C173zeM8F2K2UTYOwR9
X-Gm-Gg: AfdE7cmd721+Mh0JYjy9BRcLN10t9AVNJT4pIgKj64AF8qG42p1fJlWa1MKiXwPrVNz
	hvm7qoDTiQhnA79ptseU1viq3+//8lcdbB3eYtjV4BCOaqfj/sMk7Cesbg1QW67n2ZiGfJbRPOB
	+aDue4eABeRkvzJatSgvBe0eB9WL/Jem8zRYkSMKQlsstvG+MLkrS+o3DVLNwAY6L+16jXgWAFQ
	On4lvaY7VDjsneiiUiYT+FCXEWQA7AKjZVy1quSEe2JSLWGMHF1i4PJFFSKXGeUWxhPt3CxuMIK
	gliWu/ZMs8USo/2oF5vhMBtc98f7gzIwp0P5RrAZIYFb34SQKtYx9s/xYhhA98itIj9ujEHcPxe
	TKcEywqw0zie3BcR7a4T2QVZ7hhp5JOxHvI6BCO/ZjaK909ouvXyps3mUDfl/MmpV4ZkDHBvM6i
	4DjY+eRhLqpgBynJ1kteag1Ma9Fg==
X-Received: by 2002:a05:6a20:939f:b0:3bf:ecf8:abe with SMTP id adf61e73a8af0-3c38d512647mr21472934637.0.1784564246909;
        Mon, 20 Jul 2026 09:17:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1ddeb6sm43145565eec.20.2026.07.20.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:17:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:17:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 06/11] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Message-ID: <f0d4a047-5dd3-484b-9fb0-89c12bd93ad0@roeck-us.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-6-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-6-55b305833123@jannau.net>

On Thu, Jul 09, 2026 at 09:30:52AM +0200, Janne Grunau wrote:
> The watchdog on Apple silicon M3 Pro, Max and Ultra SoCs is compatible
> with the t8103 (M1) one. Add "apple,t6030-wdt" for M3 Pro and
> "apple,t6031-wdt" for M3 Max and Ultra as per-SoC compatibles.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter
