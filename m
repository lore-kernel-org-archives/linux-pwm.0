Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AF4AC14C
	for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002948; cv=none; b=DXu+5yfjnZCpCMf/8c8BxgSUoHpa3lZAG5ffftpeHeWTtueWEFSaqWTFy588dNqPUu8uN1InK7luDeC8lPbKP7Dou9CGTJhjn5Guwprhj+Kp6tNbgtg4yH6ahCLYtUiyabzr3dDIFR0ZXKYgMZXHodCnWvtMsDrlOPbYv9Sg1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002948; c=relaxed/simple;
	bh=lLDssI3Ig9cvLyC9Gnf2t/ppG8752TKcbDmH4uKVMvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJDLzbQr3jRpDCvOrFe3kja0nKpknbYvxE5aXZZO8isUXiGo/CM7MWnxN3s9TXJKd3IoTSIhxChe01Fh9qPXnTitLsOz9V3sk7M4BltZm2W7cxiWRfooUnN2BlKO2PpStPL+iJJ1ADgKVRjii+emiCTtRuxPcYEfh8uHeDKtPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy4bYq0d; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy4bYq0d"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a0so3429855b3a.1
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790002946; x=1790607746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=scSu49n0yZs/NkIL79oefwB1Fce7usaOArd+rmA6NfU=;
        b=dy4bYq0dogCqoDDOLnkmopm4wwSvKTdy9hHoG5AN64SzPhq7XFt0Mkur7PqNXp1sQ6
         SJZG6Y9rXr/oh6Gja4H1ZyP3QTmi9T4fVdWA3RY4AbPV1T1cej4NbyFEEWhYfNgLSkH2
         4ONzSkd+0ytqpRYXYfl8quJcu20UnCPGktGpsBW/rFI0kEEJt52S1IemxIZYWPxjJ5aE
         YBV7wm8Eek57Q29kO+awD91/7sFh4kyKDwVjYiXOL/9x2tOxOVdPIY++f3kKQpTQdBlH
         gxKirNPg32mFyQvGGvVCerLfH1CD9kY0E0E5c+KAHpM0ajuq9AkvJqOKt3WHreJ4DBQ8
         G8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002946; x=1790607746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scSu49n0yZs/NkIL79oefwB1Fce7usaOArd+rmA6NfU=;
        b=QJ3ibHPtuOwk3Tuf/ceHuCq9MIm059PNuvsVvSRMO+s4xgC6Sxfsp3M/TgpDzUfvIe
         dAz4m4XiKdyiRXYTns15MoCPApH5wk8DaNgu9F1MSaZKdBbD1TNv2z8R8ybTqAXGM62h
         FZolrWUv9gYkVy2TY9UjANYGWmmAKFOLBvsbTUcPDDqDF8scYQqZTRlRWnSBtHmSaEcw
         PfurenGFIi5kwrFFfhGaWw6z7WepO1OFfobhpqIpxMd4qSs98bRqkEkUZTeh0uXcGIuD
         S68ngj+zbvgCsjSObyll86kOgtmXJQ0wLOzNTlNIAna4wIgDoMpXBJPecaYD7TgfLhRn
         P3sg==
X-Forwarded-Encrypted: i=1; AKwUvBwSL7k3YVUWy9Jeywt6ueBPCmxr+0BxYzdEc81Kq6+SYYstXUeTp5KtP00Gk5TMEUevIUZi5piAhi8=@vger.kernel.org
X-Gm-Message-State: AFuF++nEYuSI8y7IAgZQINf8ANNiOgSPAeBzW5y3aBXZ1rW/4WIyCATn
	kNW+FObtBXGHi3UOdwL9Rpw9DqUILMjvQN0HzaeLx7rzNqKhDJrYFgOd
X-Gm-Gg: AYBFou0gsvBYYDqiaXBTmAyxSxuAu51r5hU3s4ybKZlGrrF1fXBCGeaXQD5catCZEXg
	+EFZ6Q3xFe65QiwDQs8Xn3kTrLKuW/mdokfaTRM4Pd/J4HwCzZuVCD55fRv65WA3B05jYQSvfMR
	MyoaFTpEgdi5zBxEH0Rb167sEiBavz85z3JlVxioormcfQqsEpIHHd38mF+qDCmJPCbCVhojarg
	lfKn1YJK+PgnMCVUIpEUukH2cTpD7B2CGVm39ns/FSwsiPGq60UEh9YAdzJTlxE17z2cgESAS+U
	N1yRQpJpDN1cmRQnLjgSHM1QOHmi63So02yJ3btc9+/D9YeMPcoMsdkiPld5AzHLvY2YqtGY5vk
	vrUumhVwVNK5V81CBc0ICskBsbOYeah9EeDG839L3btH4ZRK3hLHgjWNrcORzzmwFqxyalrdMyR
	B4KacoUkbF8DZX9om/gYhD+O/7Kf8DD+eQbVRacZpnuSln6KuxUPwsuN+tO7KSb42V2AbyL38Cr
	A/L1AO89iaN
X-Received: by 2002:aa7:88d0:0:b0:878:3538:8f80 with SMTP id d2e1a72fcca58-87835389b2bmr7554907b3a.46.1790002946544;
        Mon, 21 Sep 2026 08:02:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95eceb2sm3411465b3a.24.2026.09.21.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:02:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 21 Sep 2026 08:02:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Tzu-Hao Wei <twei@axiado.com>,
	Karthikeyan Mitran <kmitran@axiado.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: add Axiado AX3000 and AX3005
 PWM fan controller
Message-ID: <01278847-ebeb-45af-b520-765fa6ae3477@roeck-us.net>
References: <20260921-axiado-ax3000-pwm-fan-v3-0-3def8b6ffec9@axiado.com>
 <20260921-axiado-ax3000-pwm-fan-v3-1-3def8b6ffec9@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-axiado-ax3000-pwm-fan-v3-1-3def8b6ffec9@axiado.com>

On Mon, Sep 21, 2026 at 12:23:55AM -0700, Petar Stepanovic wrote:
> Add a Devicetree binding for the PWM fan controller found on the
> Axiado AX3000 and AX3005 SoCs.
> 
> The controller measures fan speed using a hardware tachometer block.
> Fan speed is controlled through a PWM signal supplied by an external
> PWM controller.
> 
> Add a MAINTAINERS entry for the binding.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>

Applied.

Thanks,
Guenter
