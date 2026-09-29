Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F5501284
	for <linux-pwm@vger.kernel.org>; Tue, 29 Sep 2026 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676418; cv=none; b=q6t6JtbBsiFnmn4IX5UigpyAggawLdEyl60NPX5WFzVLV/dvmgU1uiatamxm6Oxe5UXcHHlhT39BI2SrJqqY3qybKpwYh9PzZZ1Njhn8C15r4YDRDNZHMEjZyb5dF0aQ0nI5LTrkcYw3qCOT5ymQAMRibV3g2yUHbWKLRrvhcH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676418; c=relaxed/simple;
	bh=M2+HHLFcYk7VtvS0Umt037Gs6V6AShQYZEnBPnokhyc=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=J1ucQ4xyuqk3C2d8iyS+Hucwk8ilC3/elfeVTf3HJApatUSUzL8ObExLPeP/F6hjBqGMm2c3i8Q7OwTL2E0LJ7nbtNhS3n+P6cS0CJdZX+gqYL62/obNUUDVLfcngBn/8aORaF3D/1z+7N+Ben+ZddvBsVBnLColyfpO6TidZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtHYvsgx; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtHYvsgx"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b3e517e6dso222859eec.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Sep 2026 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790676401; x=1791281201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2+HHLFcYk7VtvS0Umt037Gs6V6AShQYZEnBPnokhyc=;
        b=GtHYvsgxqFb2t3A78+M3H3ME5PyfdB0PLiNaX/2MXG0i/TmNpnpUOO0ThAgNhwuBh+
         6CSBb5WO/YhR1kHjV1bVXv/YPM1upfcJMXvrTZGyheqh9m/Yjy+lAvHJBNepyoJ/7kLc
         If34+HdCbilSnVwi/mw6/2mI9LFqkE7jHtIRJkPmgI1Pi8XcwkADtioDWvXjuqSKZN3/
         Jx6wV8qzHeIcfqRy8a31b60sgccAR0I3JdjGel5dlCsjh4qZjNusxq770PPWi7sobCPi
         Nc1X/gkyf5vH0rsPdS0MHPlMZzZDf7PzXOD2ujTUTcH0znw9yAS5J1AyNHTIDPea007Z
         yYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676401; x=1791281201;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M2+HHLFcYk7VtvS0Umt037Gs6V6AShQYZEnBPnokhyc=;
        b=HB5ZLNHxUTR4FqqDweBD6Y+UCJAI4jBMKt4K7DqXsTq90ZtfmfUJRTEAT+V6dAp/LA
         lI3O5JUX31xnh/JEe1D/Z6kVOkWqv66SpFA0Ra18QmEkkAZxjGQOiIuJkPIS1OXNHCge
         qPssgOF/1FmoELwDTFP8nvUT1ZzBFoyEEo1Rgojqau1iDAsGK7A9j5S4B8DGiGOIe4T+
         AhIb+pupivXFoODhJFJT80NtnAlq6R+bnynERda8TK3K3YNPv6ZkQxL6Ie8ktvE3ruwW
         rKcTqgI/MeN7wnp+iUaVSSq4opjEtwjHFaeq1Lua6FAJ3fGWWgcjK02XgO1C/Er7s4GJ
         3Ixw==
X-Gm-Message-State: AFuF++lPHuVrxm9DYwI8sDF3pQMLs6NwFMue6niUJXiw9Ijy8U4aa5FR
	HyWeEGVhn1ow8ZcFNqJhOfhl7tMTUxPGLiBsBM7iBVq3TXlG8SMDPiC1
X-Gm-Gg: AYBFou33AYwwRFVX4yQxtZPbUDFxM898Y5ihNq2z+YiEegdmELrYcYQW/5NC4qQddjr
	K0KQz2VrOKALOp2p3xx3/Fm9mBu0VkosooQIyjk5TeZSLIFI/DsfBwLxBfUioOZNNbiVXGgWUGW
	vqI6mzsA700LExwt0ckyaEKxNY2crGA/N4BW8HJrx53PaExkb00wMWFGkhTxz0ZVXPvUGSvrvau
	Z7KN5GZIBM/A38kmCXOOFdFXTeOoPMg/0dXhAi4TFOU6+EqOD2E3D/jSVTnprwzOzpLpnyevlYd
	yPlNLxIHlkYMbxW9svTcCCMa/VWFfUuDUEvG7TswbxMpWNyGjnaqY+f2sYYw2OCs9w4VKiYLYUQ
	GqPeKi/X/GI2Un7VY5ql+B7WvnifDAtUIxk2uBaoS2ptsHx+MdgliOSmY8Wg/Ods/Lwcf0IPx+R
	bDYG3GGMHLgsTGdVLFJdlgztG3O9LjX3xdarVtNQ8z/WiQDBvIuIoalxGPfDrGnt26t2QlKYpmu
	B3GhTuRHYRggIfNGYFmNZiqFpxYaSYaL3U8h/lEmcmcZUHCTwU2uTuNPx3ZR5akT04=
X-Received: by 2002:a05:7301:da88:b0:33e:a173:4aab with SMTP id 5a478bee46e88-34270aad672mr11969632eec.14.1790676401025;
        Tue, 29 Sep 2026 03:06:41 -0700 (PDT)
Received: from manush ([2406:7400:94:b571:88c4:97ae:bb47:4040])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34b7a4d1f42sm3244951eec.23.2026.09.29.03.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:06:40 -0700 (PDT)
Message-ID: <6abb8db0.721b4d7a.30484d.cb00@mx.google.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: ukleinek@kernel.org
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: 29 Sep 2026 15:36:40 +0530
Subject: Re: [PATCH] pwm: tiehrpwm: fix copy-paste error in obsolete DT
 binding fallback
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,=0D=0A=0D=0AThanks for the quick review and for digging up=
 the Fixes commit.=0D=0A=0D=0A> Looks right, I guess it needs:=0D=0A=
> Fixes: ae5200d22716 ("pwm: pwm-ti*: Get the clock from the PWMS=
S parent when using old bindings")=0D=0A> =0D=0A> I wonder: Did y=
ou find this because you still use the old bindings, or=0D=0A> by=
 code inspection somehow? If the latter, maybe it's time to drop =
the=0D=0A> handling instead?=0D=0A=0D=0AThis was found purely by =
code inspection during a review of the PWM=0D=0Adrivers, not from=
 running older bindings on actual hardware.=0D=0A=0D=0AGiven that=
 this fallback in pwm-tiehrpwm has been effectively broken ever=0D=0A=
since commit ae5200d22716 was merged in 2014 without anyone notic=
ing or=0D=0Areporting it, it seems very likely that nobody relies=
 on this obsolete=0D=0Abinding anymore.=0D=0A=0D=0AI would be hap=
py to send a patch dropping the obsolete binding handling=0D=0Ain=
stead (from pwm-tiehrpwm, or from both pwm-tiehrpwm and pwm-tieca=
p if=0D=0Ayou prefer keeping them consistent).=0D=0A=0D=0AOr if y=
ou'd rather keep backward compatibility, I can send a v2 of this=0D=0A=
fix with the Fixes: tag included.=0D=0A=0D=0AWhich direction woul=
d you prefer?=0D=0A=0D=0ABest regards,=0D=0AManush

