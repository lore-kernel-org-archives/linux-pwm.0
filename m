Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D6374E64
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941893; cv=none; b=TfC0r7yeiTmo6N+bFAoTaywMV5jBbufa1yY7tj804SPT5bAB+Kfnufm96+qtlWmF2NxGuyMzGhiXxRiu2U1L2aciNvuw4sC9cQq5hStEeyVmV+ubCO3BuLtPG4a8bpI3VfHld7FwQ3vA4K2tCJN1QNlMpGq91hYOgP6vgdYFi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941893; c=relaxed/simple;
	bh=9S/faSZXw85fr7ERVeNcmiX7A2STfXPOz+vsocu6na4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyE3YXg5cnBnK9is8srrd+lE7JMtDGpWS9KDD1fMr2ic9KzRridhpr9tCv9djWAbsIhQkYQhI7Nho0I/s5CyIPUOS6ya/4g/eG61uwSLfll2QEyJ8J0Oao5NVHqI24mEEDlYAw5X4SFeYlgGETcV0x8rTIGoJoIav8AUIxxEmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA3v6CJ8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA3v6CJ8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38511175ad3so929047a91.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785941892; x=1786546692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qoe2BAtQzV2Z/pr4B+d9y9nLNSXO+lcdy6rhWuxxDJo=;
        b=ZA3v6CJ8WbCrpq5kc4HNlWpTgSpNPnvhmavRSWGxkc87ofa6r+7LFxX7nr1e8DJvkg
         0N8BIUWK5O45niwHEffpF/zMr8smQo2pmFD4Ocmod70jpAMzlE4Hx5gsu7oj6Fm+jfS2
         ezKWXZMyW5lf1Exd4Ocfffrsc8YRK8tg6S2/ev35oURVGAVSfbEqZ2VSf0JujWkFbICk
         jFguACUJVfDXq3YGk50xP3GD4e9+xXK4hV7xKw9ev8wQLZK5x++L5mjkYl80T7NBXwr2
         fNUYpV3kwfImsDfVDQfGs0XXFMl3ImwUi1V6KbaHpUOOkaJL1+RgkHa89Hfk0H3EKPWG
         W6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941892; x=1786546692;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qoe2BAtQzV2Z/pr4B+d9y9nLNSXO+lcdy6rhWuxxDJo=;
        b=pAkb3F8b/KcQ2ZTbUwVqzs7qCvxDe12tiWvg2BaS4H43iiJP62U1hI02WUGQwJXIk2
         xKL3U0rVAodmfwMoXvnD/QTVF6gx/EYOm7tju7Jc2ybQp6XG/+4VG1pBM/nfM1PIj4Hi
         byXM4iUywZfvRoEUyjVvSiuztIaIXvu07EkxyFAbUuhrDqAdoFvAluE30+W86mrM+j6i
         4auHS6Cxf9WKb+naQOsdl+36FHqG6fQ9FBySOlX+sgOmx/yF/Mu7iDC2RjBDGtcax6+/
         k2jaI4TXqagfIDDu4rfF+BHDSnIp9dfNiXLdADxe9ZlKWoRlPaDv9FEoky0WcRZIjLxt
         co8A==
X-Forwarded-Encrypted: i=1; AHgh+RqBAHaLLaNAg73ay1zivUeZPaIJK15XVAOQfInwM2GhrLXH9f/pnFlEzYW6dfKtPcLGcV8WMG+4aOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WNsnNKbZJ/GXjB7P0QqMPWlfh+PO44361dMyEcmP0xj2S8Nb
	+xUpZPVAiYHW4KQdbRR29njYndt9MEehtKTkaVdumK+6vsA5hGB8rVUb
X-Gm-Gg: AR+sD10RRZJ6Q6lRMpIHNJ7moNqYhsUj0Fu2y53/oXKOMMz3uiPL6PipQbA8YQSOfbC
	HLXg2J/banCxWduN2Gz00xLw51mBPgY+d6aSt8Ams2RgH78+EolVEfxyWS4RT5IJDFHSol3f7CA
	K+EqbOKJDBb0x+QC40Fy0syfWTyFfwLzsQyJTMMSZdK5VVZk6GKKZETs3mQKl1XLxUSMwreXedc
	csIcDiHmi9r1objg0Xps2PvdlxEgQG21yMcbPDSi61LulAyDzRsrhEUKI93RC8J1ZT5FVdE+5Bv
	Nqlv4cgpdLkANhH3glvci3Ak2FMpUkU3E/IoOvq+M0yfiLx6gM4LvZD5l/PlKxIbPxLjnM+5ev4
	8ul0yeu8BgACTJBWEnb3HwpFLxvXHqrQObZ1hAqHGA/kkFmfONWBrNCA6TRqhh8VEaP7qOEGTF6
	kFUPR1+nUcSEcwuZVOMGbqpyZe4u7j150Wh35u0utnXtQW+jAwgyyL7+1E/oC+uKi7NyXoTf8Kc
	w==
X-Received: by 2002:a17:90b:280d:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3903c54fbebmr8588690a91.1.1785941891593;
        Wed, 05 Aug 2026 07:58:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df88csm13204639c88.11.2026.08.05.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:58:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 5 Aug 2026 07:58:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v6 2/4] hwmon: (adt7470) Add ADT7470_PWM_MAX
 macro
Message-ID: <f6ecb967-b77a-4983-ac2c-3b33822480c5@roeck-us.net>
References: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
 <20260805-adt7470_thermalzone-v6-2-5605a5f95467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-adt7470_thermalzone-v6-2-5605a5f95467@gmail.com>

On Wed, Aug 05, 2026 at 10:15:18AM -0300, Luiz Angelo Daros de Luca wrote:
> Instead of a magic 255, use a macro to refer to it.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Applied.

Thanks,
Guenter
