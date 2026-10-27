Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084058;
	b=ofRZUu7BnMep4yLlI7wXcihc2FXj3ukj9quYUXDOrCA+/fWS0S2AArRddFExko5qgxtG
	 AhyyM13Zdj3TK+kxlRF6WB3kvDT9ZRF29m30qhdaD7kYU598bGB4BkSoVAH/mTEvZ+Jvz
	 n1YjjLMumndfwDI30015uC8lp9qnJtyhJ7ORUoNvHeIzy1NP0z/Eq8VkXaXeFKrQbg7OB
	 1hhRzijk3m2UUDmTEFBRfKPbJ+La27Gs7P02OOEM+4HnLiJMHR4HDaYgBWOAPq0UajiTZ
	 DxqBC0EZYgmtW90lIx/0pBL/DcAy487kVUALsxSa8ammKwvEmpuMZV5ETXvD261Bc6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Bzi/nzvXhzox11rm3/brp68+yJUnNUbuR0aBy7BPR1M=;
	b=lA5D8ZZTcbSfmwvANE0pIG8Nvzzrmmd3zLTyOELBj7iQJ+3W8qIxnkEAFD8zCwfw+X0L
	 xkqaJ/sZks2LxdPhwb12e4n82w7VpFp8XpgDlMCxqbInVjeYIhcOy+3qXwMacTrJe6jQ/
	 l+cKv8XQRG7V/8B9uh4FwWbJNquEEs5vr/bzqaXxXoo2OwmQqOWs6laC7TzFOobND9zMI
	 D9YYWqApjE4JttC8Pv5iQPCvei4MqCfc3EMU9vZk0J3bZ0sqfksfrCU6R9worl+H9KduZ
	 qkJ5TGMffp1AiLtP+MPGpZ2qUUn8RGrKQE1W55+IWQ5VuMN2fEcH/vzPxf23JKEtbDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YdTkeEtL;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF8606A31E
	for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 06:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BDF8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YdTkeEtL
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so16210105e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2026 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793084056; x=1793688856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bzi/nzvXhzox11rm3/brp68+yJUnNUbuR0aBy7BPR1M=;
        b=YdTkeEtLL8Y1nyxDjIKjLsf/YxluDeSEZ5d6kdlAWCIbzAlWEKnDbytZuv/smLkWBi
         xNi9V99FLlNwMWaPKaN+Gntqh2AawHuOMDUnL1YicLxV5ve2whO8abtEnPdq+lF6j/MG
         dNa3HV+fWdTQJupDLPJ0yiKrgH4PV2pVmDQwAMyCvIw+AiiSQLzPSN/YUfBlx/yhJrhM
         duKxU9864eJda80HVDcv2dHBVskc4qsLEqF5TQIKV6gfdxzCQ+9EkInOoaw+hUxHb6vL
         RPAiWNu24DYqNRcxYRzUv7/sDz7AN89CrKUFjqQqNzANUD7P7QaACJ+I5jTdhifdLkA+
         kxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084056; x=1793688856;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bzi/nzvXhzox11rm3/brp68+yJUnNUbuR0aBy7BPR1M=;
        b=j6ztEQWpqCfHPO+9KFpTSG5df/NuAQ6OzY4662koIlLW0zMOsGiVtdqwAQv5n+i4U7
         zoHGxv3xWNDStPcVq+m7qwaai5iUWOD0og0SW9BZMdsk7X7wOUoznzTzr/65lc3pnFoG
         Y2LEDSnuKt805juR8CypUPkIv6fWeTsnri2K5KPVvn6rqdEhnXUehCUyMGGweh/7AzMu
         NtMRECgoeg7yRCGjaF16Age4biHIns3dcH6ZXALlY0rvl/qHVUlvpFGwWKf6UVuasPHt
         Cd2AoAASaoWmKZ4b00VdvYKowAjuqgm1uAS80BOXJ5sjSTzs+4O2KrioYGnXXGOoTKLV
         Dc2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwa2P4gtx0Wm/4rAEvYwTepRJahJyancC/GqbKGXAMP/9jwlNOlMK5118NYQCEG0NT0q78kw/EkS6k=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+6S6Z8NcIeO7zDMqBttfQnZn2nJPkQa6rh92+zpbh6N6Iw2RI
	Rz7oIRn2DjD76n46VP4Ey0ngNj6/GwmHJPAKRmqPx4qVaz+Y87Tb2HyK
X-Gm-Gg: AYBFou3ZjaMDtB26wPiBZ4xgmhdk2s91WxMpjToTb9so6CHh1b+b1lz137Bp/nyE+QG
	r6q+WLdvKF9KdlUOC13R0gibojJpjbZIjrs0b0cxQbzBXsHTZRH0m7rp1hWIbiKcigbIOCK3++F
	QmRMlF+UYCB0+CbHpBv1V4Yhao7/yhN79vyOZUPzx41iBqvqAWc418XK0v2M/muBUt+PssSc/2h
	AAYQRbaUJ7kZMsH3yVZwpELXgaJKijl0XbrP83spRDiKLeNt2+zGLl8WlqCA/o8HvNMsZLrtVt0
	4L60gkIbpkoVYgsZXH0w37dkrAWBtQrs/OGbQ60wTuVYyIEqhsQSKbDNlG75q6uALAFE7R5u61o
	8lFEUANZjBSGlfhPF+RMMEaBdHw8d+Qby72WxEOZ3gD+jBva7VFl+8C3XvUAjGwPzLl9KoG7+zw
	WJD0B/AqCELNe7shEpWqtgnxgSECzDPOZEvPHmpWx7uv1aFm+vn64ygw26aiA4lNsK55wnWY1hd
	kNDrRuI/+Woi4NpebDVkxlz3leUaUDPun5b0NpMnhZNqjpMXUyBIUxvpuYD2ZUkyO8iMz5vmK/L
	z/8H5WbVIy4NPMCB1EZEU7Wol1/ngjRdZI+Akb28jogN3e3K/eAyFHVTRXW/lJiwZY11nJQXMgL
	QPCH5v10j6A4qhkhDRUox1CKQ69NPuZIrYcm4NyMgLiw0Ol/K1RrT3kLSqU4HbEmj55GJQk0LFJ
	WgyScw
X-Received: by 2002:a05:600c:4f0f:b0:4a1:acaa:c355 with SMTP id 5b1f17b1804b1-4a35ac803e2mr199062215e9.10.1793084056219;
        Mon, 26 Oct 2026 23:54:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2ac-9b01-6900-1f92-d182-4435.310.pool.telefonica.de. [2a02:3100:b2ac:9b01:6900:1f92:d182:4435])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8c05sm26916356f8f.49.2026.10.26.23.54.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 23:54:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] pwm: tegra: Fix value discarding for duty and period
Date: Tue, 27 Oct 2026 07:54:03 +0100
Message-Id: <20261027065403.96505-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261020133938.191013-2-u.kleine-koenig@baylibre.com>
References: <20261020133938.191013-2-u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 03:39:38PM +0200, Uwe Kleine-König wrote:
> Compared to (implicit) v1
> (https://lore.kernel.org/linux-pwm/20261015085336.4181137-2-u.kleine-koenig@baylibre.com):
> this adds more adaptions to handle the bigger variable types, as found
> by both Sashiko and Mikko. I didn't think a lot about the
> required_clk_rate calculations, but I guess the saturating math I
> implemented should be fine.

Tested on Jetson Nano (Tegra210, 7000a000.pwm channel 0, PWM_CSR_0 at
0x7000a000) on v7.3-rc2 (5b0764a53235), starting from period = 10000,
duty_cycle = 5000, enable = 1 (PWM_CSR_0 = 0x8080003e):

- Unpatched: writing period = 4294987776 (0x100005000) succeeds and
  truncates period_ns to 0x5000 (20480 ns), programming PWM_CSR_0 to
  0x80fa001f. Setting period = 2415919104 (0x90000000) and duty_cycle =
  2147483648 (0x80000000) casts duty_ns to a negative int and programs
  PWM_CSR_0 to 0x999a001f.
- With v2 applied: both out-of-range writes fail with -EINVAL and
  PWM_CSR_0 stays 0x8080003e.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
