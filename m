Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794780859;
	b=1CMSo10FCDwJDW6pG1i+WVF1l5xb3UNWU/5HnDEkgJLcJ6OjY2T2ZBMHb+QtpPJo2+12
	 aENa18v6X/6UEdZmWqkH9yIELTq3setb640WKSoyBsHCA4EJdR9PVFXbCNLyvqDjph/GZ
	 6ntYqLVCZWSe23IzY2RSb2Vd5Blh6zKUT99aZrBUsMdZE/kfHSAp3YBYxncCXvppI3X0d
	 DWS1ylUPe/32UFnuvPQrhE8/f7NNc66QtXdzaPtTGLaMNHHdZ/35+fIZmViS1OzbSaoja
	 7yeqSiPfNcfNLKo2OPTNayVMz60jrnjZQY9WnczBjdI1+25HPcGcMCXYPjOkVVo+BtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V+qix4MwBv7O5yjEyViR1F6mCZNMRdVo4wwBMAHfu4A=;
	b=bu3SawBtb+Qz7dGzWnCBPUAsRvfyEUeLnuy1KaTazURzYe7DaiCZbhwQbo+/twfwt2OP
	 wKBxq1Cc+pNYhKMM8IoUAfzD4AcTcuuIoYq2bExPJd+Lm5xoT3rDy4igCWMgVG7pA7Ji9
	 Kxxu31nbhnfnYHxqb6TGTeoddwe+UjfWCMbfwYNzdlryXSLbLBPE1gpsv3gzd3S/YEk12
	 9vfE17ovxdz1UQ29YQ2i1XbBLb02jUMmZXI66oC8RRPZHhdN9XG/bD+ofnZDkLHUmonVY
	 vPi6nxzohMDHqTlIGS6dgrrZ4Q2op2EF9GbV0CAb0BUcqXpTKJE9WEZce01aVFJUrCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=vsbtJ9cl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F8606A31F
	for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 22:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184F8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=vsbtJ9cl
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67da69e7c31so1018669d50.3
        for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 14:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794780857; cv=none;
        d=google.com; s=arc-20260327;
        b=nMrROXAfDPhmu6FIzQiBqCGw8H6illImd9tKFZJWN84kocS7qLsvcObfWrZUzQLg7w
         PAU+pDB7AdsqrNcP1mFYe/0F9pma19Sc0mA1pOqBedXZeqr3Ty19ActjiVATK4ZJugUm
         i+aRK29bf8Zs/rgaaLoqjaHTlj4ZhDwWaXbqr78aQFDgmvitwwO98SA0iQ77EpdLa6/s
         rkGN+UrtTeUfzxIwl479UkQybu5f5j6EA1t9NELC0HJEkBH2oIO6awp/edl/A42f3Xa+
         ixkZCqGr5pOzpQP3mrbU22/aozIaLEteWOjHk28E5xoP8BH19qULWPZ0NDQ89cG7Bb4N
         +5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V+qix4MwBv7O5yjEyViR1F6mCZNMRdVo4wwBMAHfu4A=;
        fh=DJFi5fWaDREsxuLiZa2Qom4Sinfv78QuV+jyroIqwSM=;
        b=buVTiBRkr6NMG3vd85PBWo1+1NgJnuVbFrUkHyybhwny8pwEHfP09ehe1EtzAbyoQH
         MBJhILn92yoTD4l3SIl8G0CBtaoYYRFFHK9pe6j5hFyC6RsE7wYKLbNuoW0c/xGtJaSv
         d2w05FGAg5LzxJ/Ini/9jFaygBkp6v3wcadr+u2jliZU8Tp7c3kviJCJbwwK3UCYgG4u
         u3h03VXdTfbE8FXleWXC9BGEXdY8B2jpZ+D7TWL7x+4m3KXcHunumFPOe+RopYHHahAQ
         fmwsXUCaAy9esD2RQaVCxJnVqvCIq7U9hVOS39MG74of7kYGJj3tPI9Ti+AEV8kRuxkK
         dOIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794780857; x=1795385657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V+qix4MwBv7O5yjEyViR1F6mCZNMRdVo4wwBMAHfu4A=;
        b=vsbtJ9clm8nCYaPATTnPA3JLfKioT9Md4IUGq4/CVtMGeDoUnnPaeuEG/NV8i6/mLZ
         DKSBJm8dsAVm9R/leRKzUT7O9bJuh9idzY22HZ/pOYHy2i1muBTO4iCjEm/Jvx2A6faB
         jcxy2OXG4oiUgjnqVdwexSm7ffqu2N86/AnBaAL5rDwIBdj3cScB6bcmUbaP+8ZmvsJY
         Av1T5mCRRwOQD+nwKYfpG0ZeK/GQ+EPAUmhi47sogyxVxMHkXqhiADPp2dqrxEib3bkv
         PNF/WsDvOfA7DehaQYRAlOIWb9XViqp5JDVlwbr8ae/MvmuaXKFaqqfKVUPXDU/sjFec
         JttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794780857; x=1795385657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+qix4MwBv7O5yjEyViR1F6mCZNMRdVo4wwBMAHfu4A=;
        b=SXKbkbSYQJSys5gK1S0f9TWezjxud1jFQM02r60hFhUcr6bkCQIwnqeoSFNO99HPxl
         GRwKugkLi3Hw+b6oCPcrgUeTFPpq6Y4nnov5hcw+eRrjyblUZJQaVhMh5VXQF9CHYRr+
         zYjHW7VNrGCNHyHmjssf5sZgmVqvu2r0GfebvK+7kumf4zwCOkvo55wLMa0ljoikzX3K
         2AZA18VWqPfhTWSN50QSgZch9Gr9VwCy2ckIqyt+3QNRkSwGuDSHh8BystZLXLnxHqy9
         33NyuMEZu3yX7faelI+Qm/bmO4fUrf5r4IZDXSCnv2MyjSotjMw4ZV764wqTbcwrQKYt
         eU5A==
X-Forwarded-Encrypted: i=1; AL+hErFjP94+p05QEgCz3J3Jps0kH6jkTIBHRrXUVK9sTmnI//cQm0lPeI4IaeUegmnsnIRcY2rIt3PPuwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oAXj+LCtS477dK0y85AFW8X+f/6Mm6eeU5dRdliOnrhOr1flr
	d0v6SJV371/3kZJZiEfsq7p3SiHrZ1SagPm0Hx/GZtcGqWKSbJ3jY/KpEekWCzIO77IbSDD3Ux7
	eqJoqSBENIGeCk9nxgOcJQlGbUcWMGg8=
X-Gm-Gg: AZFdTZdN1Z8l84fAQ40XRI6B6LLNx8aTb9E6hhGreldilWmJs/l+pa9nwQJJrToafMd
	r5NBS3yHcR6RsrJMCXhfyK9qc497hIbwe84fFgTnSt8jd4lIrTnBMwQtOy3cDjUhtX0QWnwsw5R
	7qCYZGOaUOHhyQXToCeTHmigDf+RC666jlKzBoCCCvngavG9RDkx+GHwHGrj6pPhTg58IRthFBU
	JlLCNlUu2hUVQZbJVC8MGfoJMtsKEbG58A3B02h4pDzIvgWTQxOiJBtkVd24kZ+aiygtStj5zfs
	8k0OAecvw7C7VdZVuHe76aH7s2nLNZ8vbWi8487IzFbxayDVJ7SaqRxcAqdS4x1jly1JqVSRgwI
	khJ/cncAab3X/UAwe7u05iIaiNsl+qzqtkAYWMiSPGTHe78r8ZvpBLAOiAqQQfKvQgkDv/g==
X-Received: by 2002:a05:690e:4383:b0:679:f97f:fdf6 with SMTP id
 956f58d0204a3-67d896a8f2bmr3982114d50.66.1794780857112; Sun, 15 Nov 2026
 14:14:17 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr> <20261001-add-t7-sys-pwm-clk-v4-2-8ed2b1e0cdfe@aliel.fr>
In-Reply-To: <20261001-add-t7-sys-pwm-clk-v4-2-8ed2b1e0cdfe@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Nov 2026 23:14:06 +0100
X-Gm-Features: AclHuK8Jibqkumh92MwUwV6k9LdMNZ5aOXfzAlbMwGyKMualpiO_cItbFylPmew
Message-ID: <CAFBinCB_Eam76VJWSWSyLRsnzXOTWohrE1NdqyJ8GhPFjWzfHQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pwm: meson: Add optional bus clock for S4 PWM
To: linux-kernel-dev@aliel.fr
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:56=E2=80=AFPM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> On some SoCs (e.g. T7), the PWM controller has a system clock that must
> be enabled to access its registers, in addition to the per-channel
> input clocks.
>
> Get and enable it with devm_clk_get_optional_enabled() using the
> "bus" name. The clock is optional, so existing SoCs and device trees
> that do not provide it keep working unchanged.
>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
