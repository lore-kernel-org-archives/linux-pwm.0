Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C0241CB7;
	Mon, 13 Jul 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938672; cv=none; b=AS2ZjMdnOH1AP+zdRbR/9iX1ChTNwhPNS5jbJCdEYX9jR7cvMeQAZlFmijX38tIbcUMnfkN2mt5QCl3LmXE/vOvQBDeJSeg6gGbqiHzFZAyC5xYounMb8f1gslxMcEKSeGJxJ/o4FiZOTcgsg5PAxyagKDAb44KfP+5yIFFtqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938672; c=relaxed/simple;
	bh=wh+uN6f3eO+lPJjDVHzrHbfBrUFxnl6jt5FYXiT10E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJiPHeqSRVc7NNPmh5/uupeSUrZSMaKoE5QrS9CFXJ1aCWHyI+qMTOGC1szgPANCSkF8H26cDigIUoPJOxQ7JwHIGphSC50k17ORtIAfEl3N8bAGvmWlAh5V1gpO/ngMG9gOnV8mR3df6IX2T3QitiiPK+lQ/K+s8PMav7xc7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6P/q8Mz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oW662zGa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6P/q8Mz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oW662zGa"
Date: Mon, 13 Jul 2026 12:31:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783938669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TnTJYFd3ykPUbgMhCghpq45CT2aJ0C3b7XhF03Le8p8=;
	b=S6P/q8Mz5yWsNUY5WzF0O+VnLj1I1ew+amkReHeJKEUerqSdIMEz4nWCu1mytvMQU1yKMX
	g1VSUTT4rGQqWc7FJiGY7/aYfpYGEVWj0v51mYXEgmHXsMaqKQxZ4bxXx7TkE5VyOrTh/F
	ZxcVGRs4gixKNXFo5mnKT8uqKf5uA2KBpSSSudNcT947IQNs2MXhRCkZMEFpJZ/+nLQL0Z
	6AaHEROInIKVwtyGFY4iizezFZoJrtvkRFd11nMcKW1AS+tj0qNfGZh0m/dlnCYrOBYWxy
	aZ9fnW7b3CWmgCm3/cQYr+Mu9QMmsZlqIqOpR0dKP1F4FWAmozYsZusya13x7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783938669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TnTJYFd3ykPUbgMhCghpq45CT2aJ0C3b7XhF03Le8p8=;
	b=oW662zGaP8R/BKUNGQf5ru8cvBBiUuVwpzd3+LGgmrof7ZHUE82UmEhFCNSCZRuOqnB+0N
	Mfkzbp8VobvzFnDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	"Uwe Kleine-K.nig" <ukleinek@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] clocksource/drivers/samsung_pwm: switch to
 raw_spinlock_t type
Message-ID: <20260713103107.Yc-I0-xh@linutronix.de>
References: <CGME20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9@eucas1p2.samsung.com>
 <20260713085653.1145015-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713085653.1145015-1-m.szyprowski@samsung.com>

On 2026-07-13 10:56:53 [+0200], Marek Szyprowski wrote:
> Samsung PWM timer might be used as a clock source on some legacy systems.
> When PREEMPT_RT is enabled on ARM, regular spinlock is converted to a
> sleeping lock (mutex-based), which must not be used in atomic context
> such as hard interrupt handlers. Switch the samsung_pwm_lock to the
> raw_spinlock, which remains a true non-sleeping spinlock even
> under PREEMPT_RT.
> 
> Fixes: 7aac482e6290 ("clocksource: samsung_pwm_timer: Make PWM spinlock global")
> Fixes: f11899894c0a ("clocksource: add samsung pwm timer driver")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
