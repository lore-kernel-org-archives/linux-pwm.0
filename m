Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826202;
	b=Q8vGXEtFzUJWrNLrLfQc0lZjqU1KSn+CM9SKvgmP3ooONNnhE9z2iCRIGCSba9SddoVv
	 rV2JNcuOReDU4tyokB93aKTWWpktTiYed7cvwzCTsrP6OwSR7RZxkfGbOE7ICjjCyBRP3
	 paLEeuoMyGGYwffyqmOhWl+/PKO2Apqq5IN8wtBhNzzSdqqxyvVnzMFy//V07zoA0/4ev
	 UHyA7peW079ePzYW3ebqYYPC227c/5bZcupnzzDNLxouzo+ZpNPfCCGYcFPx+Q11FwWLM
	 kTQ0kZe+zHmfiWoNFyznvGs/KZrcu9MrpB7DJtgtAlOQxbpPmqddRMa0TY2UOHCNH4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=kh/xa8HGjahPAuh2OoEJ1AULPxuRAadGF7CKojxM7CU=;
	b=4bwgYstcQrtogxnRqejVmijLwEDJA4wBLOH7VoNp8REgfETA4Rw90HLEb8J5rYZcom2d
	 MWtIdvu+5WpWCyHg3wVFR8TDk+CeZ+pQMb9l8vx3LJrV5z0Yo4O4TYHWwbxZs5GXSM4Z3
	 4uHuuhdykN4BT3Jou5QvAERYX3LmapUgPyeJeq/gLTx4Zf8EFSH8+LNOb/kBkYCiheZRn
	 BrndBtATeAQMKgnEE+SOL+9yFaBGB8Gt3CwfZ+yC99l/2DO7rDeHtm0XjCDVqPAzn/zvk
	 9L9BhW7b265Aw+eYgo2gjL2qnBhkevZL5WCN7df3EJylEmMWmzY4nqxWAoE3d9iguTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J6x8Z0je;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4B606A31A
	for <linux-pwm@vger.kernel.org>; Sat, 24 Oct 2026 07:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A4B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J6x8Z0je
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b042c0759so995043f8f.2
        for <linux-pwm@vger.kernel.org>; Sat, 24 Oct 2026 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792826200; x=1793431000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kh/xa8HGjahPAuh2OoEJ1AULPxuRAadGF7CKojxM7CU=;
        b=J6x8Z0jeMfuArj7rumhIDG6cWCktj7G61rH0jgf4TRBjj12ZaqUyFKLmuBADUPowgL
         mLAnqb2h2/22xpyVKDpDDjGFYXxsP2cdWjX7kbaOZVb/MsvoOY8/PNXzkh7/taXFfV66
         MAxXK9DwrU+aLCMCyxjzbmCPVbBQJ5et1kOqzFbhFmoFxXStp8pz9GgGoUqXEdHAAaRC
         exq2qwPxw0z2w2H4z8qRvW/6DNpM2CvjJceWpGZcwhE83P8VYWG+WjGxPM2jddC+Luis
         aQZP7gWPjJaVhbipkyD9w8RiCEYKPF8k9PDmZrM0FGaLATPoHV+08VXJid9rGq9lIxq3
         zXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792826200; x=1793431000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kh/xa8HGjahPAuh2OoEJ1AULPxuRAadGF7CKojxM7CU=;
        b=TxCPUXe203Fh0UhKLRSbPUbYuzFmskeGlY9AeI033pBPh++EAqTxz51wdRSg6xbtQA
         4szWKWzoDnKK1s/hl94bja5LzihYvOBSguH4s7TbJmkIrDzp38ozSjTvB/ocl/6pIqdK
         FIB4nOuwcUy/DnZz5fO3SbUZ7u4JxAfgVq5YHRu+JmpEoP9uli6x1p3QR4kXtTQBfV2L
         vrVQ/bpMS0vcmQtHPBsXlZGn6E9+GrDZF+dRL9Qj7DGiRC4boGM16Glw5zM7zzR2cBOc
         91n6bA0j1A6tHsMu4JdhGwWJG3AaRjCk2x5ptRAj4HmSXEo5fH4PtsM4gI+iISCSKwbo
         c5kQ==
X-Forwarded-Encrypted: i=1; AKwUvByc2GtsqO22NejTfy2r85hAuqOZVggb7hp2FSCK2lK8GsvCr4DJxunzi6F0jpD4zveWh8csKpVbI7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+N+dkptw3rsd6TWB5FvDIB0IkNMO0SHYPbbQbCHrBuBe8VMQ7
	WzKPllhWil1Re/bLif7WXySImPf70uZDQooBWkpFcW5b2D6EVciN48qgRaRF3A==
X-Gm-Gg: AYBFou3GgJf3xNxh9Q6+Kjah/Im1g7zTFbNya2rHlnwksaIfexk8Oy/HXFbyRN2nTGc
	ZJLobdKyJypZ72DapvS4kx8wcYxa3G7GLDnmGR1i5xksDjLWvo5xt4334peACphwLhby3n/UxBG
	ffizYwnQjtfesNcTiJ1lIDhYH/7deFumU59wISAbkiR4OUi9bqqk+gRNNvxIMb8VaTW2s122yHP
	gpLtW/Z2J4aarlrUuTz1s9htdroV0xTuiZjchl/zNFRTvTskH4fXrrEEWEEKeofeKwZYOZN/sge
	T3bh6gT65TTt1yp2OzrlyayOSi0i+6bQjs6lGM0ahpuvq6t0DlhSegYIadW3lYPXMZOUn35UL7y
	+CF8aT+2zRu43b/k4IwUr/KP9iDkVvTgAqkab09mxjI2uYVUpLUAtkMglJ2LCg+G3fEIkZlw4JF
	ai81zZBjIkWiM+7r96ScI0NVsLfDIsLxbxjDEvRN55gddFnr5mHyiaw3DsnYm6D8ixfj40jg0a6
	L4jhTwf7I+qF3hZHE3ewL+Y7PfXdZHUlw+gYIRbfreoGZlOxx9OGrJI8+bdhGUzfP3+9PeH6ghp
	qMUF8FEHLgwopKboyhJ2xZPhJyxUwCMg+yabGntbHSJmkeI2MFhFfqvqsPy3BSKc7W6mBGnAPuo
	2Bhgsg63QQM4FQm/qwtpYvcpFuOdltjJFiLwKmj/kbwYyiJ65+IcoCOisOQ==
X-Received: by 2002:a05:6000:46d4:b0:48c:6fa4:fc89 with SMTP id ffacd0b85a97d-48e3eb8672amr976542f8f.12.1792826199930;
        Sat, 24 Oct 2026 00:16:39 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9da9-5f01-d5f0-7ecf-afa4-4bc6.310.pool.telefonica.de. [2a02:3100:9da9:5f01:d5f0:7ecf:afa4:4bc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4d8dsm2794954f8f.36.2026.10.24.00.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:16:39 -0700 (PDT)
Date: Sat, 24 Oct 2026 09:16:37 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: atmel: Fix prescaler for periods of 2^32 clock
 cycles or more
Message-ID: <atxaqNeZdj_-gAKM@gmail.com>
References: <20261016161221.16553-1-kmehltretter@gmail.com>
 <atnHHaOwTkI78_tc@monoceros>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <atnHHaOwTkI78_tc@monoceros>

Hi Uwe,

On Thu, Oct 22, 2026 at 10:29:42AM +0100, Uwe Kleine-König wrote:
> >  
> >  	if (shift > PWM_MAX_PRES) {
> >  		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");
> 
> just above this code snippet there is:
> 
> 	unsigned long long cycles = state->period;
> 
>         /* Calculate the period cycles and prescale value */
>         cycles *= clkrate;
>         do_div(cycles, NSEC_PER_SEC);
> 
> there is another overflow happening here if state->period * clkrate
> doesn't fit into an u64. A complete fix converts that to:
> 
> 	cycles = mul_u64_u64_div_u64(state->period, clkrate, NSEC_PER_SEC);
> 
> which prevents an overflow if clkrate ≤ NSEC_PER_SEC.
> The latter can be asserted by checking that at probe time after calling
> clk_rate_exclusive_get().
> 
> The options now are I apply your patch anyhow and the above can be
> addressed later, or you rework your patch to a complete fix. What is
> your preference?
> 

Good point. I took a look at this and will send an improved patch soon. 

Karl
