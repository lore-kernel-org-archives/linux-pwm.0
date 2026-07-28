Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE7EEBB
	for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208923; cv=pass; b=VJ4ZGtAj7Yr2OpaQaIuNFukfVYWAZPBBaCVs4KwlY368+HM8n+WupYbM7Ku3CZDVKw2Tr+YLTERaNejguiN8px7yok5gsXhbuf1c9F+5XGHA5R7Ye7YHvQdSQSktg1///2+E0fEVAcfFCnNacqOUjsf9FL10D+WVlv1I4LrEaIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208923; c=relaxed/simple;
	bh=Ik8XWNx14HMmHxgerEJvinOrG7Nu0p+W7KV/S0G2+X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3cUnJHhsS3N51RKeDoKxPisiC9d26Zj10K+pXc8ZHTFZR5yFF2Y6zI+mKE+fWSokEQ+6N+QS+ptIZZiyBxdY6VRokxhafDYoEJf7tDFH30vrhZvo9itppfYuEzdUlozO0y5aYYVQiuhbMTq66IwG6DAFIv/w3QhuSDIgXESRqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPVDr+97; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPVDr+97"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448b89f700fso3097897fac.2
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2026 20:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785208920; cv=none;
        d=google.com; s=arc-20260327;
        b=S40s/CQHNUjKLKukN0EaIsodP028C1vuoEP1ng8Cyey5ljbamQ6khgQN/GgbwPrCxu
         QWZkGJZT27ayVCiHDoen8Sfn70yeJFmuHX6esry/q4CAmVmye6EXFI2mvtmuT3LtrNwM
         KhyDeSX1YIfQK4oXCPjamgBtWD6UwGr+nouY+S0HXVY/NX/A0+q0pq9oZSUYa7Vk0YOx
         NojRHmuPAkgS5D22ZfVX0ks56zI9vrgsSlhcdJ7SjTFDVKzQqzmMQDLfnEZ16vpLMOnl
         hzCItjBlAeZ0rbWXFMoqlUfj/A6IL4rWHYlLK+AZ/+HCU2T4JOHJDyoP8SoraYAhP53l
         6KkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ik8XWNx14HMmHxgerEJvinOrG7Nu0p+W7KV/S0G2+X8=;
        fh=N0SsmGQmqJuNb9bqAOIDE2Te74n5yjZofEyFNpKUDYs=;
        b=Tet6Ba3fpt0koGC3gziaZAVCutyOzgz1ZbEl23roIcz7+lgQeHrNWkvJl5gKg1iQu5
         jRN+ptmGD7ZjdGnG2jh4E/6j/FOZpMzLQLDaP45+TXtjd39WU+SFkaDgVHAUgBrq8SEi
         FSMucRLlhhx5Txt2o10/7A+rRKZkTgEhasctC/Vss0/8JirqTQQpsI84kbCIZEqFXmx8
         9sg2wmogf+I0Ku4MU24oWTQMQCnByZx1yqIUCfijjUGa4JOEh8Ois4VGdAsnNI4NToK3
         jNf/W0fPg+2934qS8UBM4wSIEEGOiV9E8JIK81RlGHQ5+WX1W2Pb3EsjeuEModcPSETq
         mH+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208920; x=1785813720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ik8XWNx14HMmHxgerEJvinOrG7Nu0p+W7KV/S0G2+X8=;
        b=bPVDr+97Xt8w9k/bvOcIP4tno+Od0GqO0ILA0kXCxoQ7C0jctz+SFoHu3lndpTYTLc
         Nbkbp+VmYo0THdV8evH3AcyI2r3riOKyzD7O0vqpPKYIydkzdTGxrLi2LLtJaT6QRJUI
         pepT4Tt6lBMezscd7UQQPgKgazw/47i0M9CWYOL5h39QEoeap42ksmgHS+kcB4uxXJvS
         iV0O03Qv8vJy+RbV+8y6esRR0YDBDoqgjRCx/kEkQzBTtHlPPZ3cdlr8MTDw46phNvVU
         SfSej8NfrpmXT3lGhsnfA4v1MQ+Rrcr0jUzwLwcVUBQPFx8z0+MVbXETU2Z2F+YD5LHV
         PQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208920; x=1785813720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ik8XWNx14HMmHxgerEJvinOrG7Nu0p+W7KV/S0G2+X8=;
        b=MBkU2lFzAOkyJdslPeTOaCugk5acY2g9HpQkz1DpDnIFd2GKi1nHhG1IkridOzS7Zy
         Xhk1LJejCjG4opoPuCHVY6QwN9mfhHT2DccHGXywtkxh0THBRm0y27buPiGJB/5AEaRQ
         nHXthk4a8O21GO1ckKAJiOGwLS8TQlK5oyDUmStutbKsoCSx/3cqCX/6++gpPNZktr6j
         NftM42ivfj4XsjxfAe4jJqeeixWe7YiFWJ6gwMt/sKiAvIR3HhczvvW0L0mnXbPqFg/l
         IsnGYMNxyhSGKJknCJlFdU8t4JxKCf/Y4vghPfc5ery4BNEMGgWCX9KXihQuV9tKeKgW
         ehwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7lh/RbeXE04uUqao34CWz6/CqWRLcAV8ltjUHOW9V3r37MmwpJOub2yFLxK7sLTH4aFsIVG1aZXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQhrrYx4rw8gEG1meU4c56NcNv3Msdz4BZEeQ3pB/3Zq3hlyz
	bbcW44nieopSXm2/X/lIx1i3BqhjWfjl+MonhBLwumj6twlq0rw1rETvXKxYe2Tt+VaolPSecJ8
	eznkmIH6ZXLwKFcbA1fv8YEMfqQADMEI=
X-Gm-Gg: AR+sD10fIrk4XhmNBy8WqebIRxitXlOD4Nb2psOwVeljCJDg6Ww8E1vEUu1Y6KFukxZ
	1qPh6qSeQiNnjzimTsiZYLoFaPkycJb92dlgKbsmOIi1uNtxst+GI67/REEmjlTYCpar+t0q+iW
	h+Sgymuec/C883TwjvDJgCAxbIXh4wmgJC5SCCgc25H37fP44ADmcCi2QIzzqmacJGlhWJ5EW9T
	ZdQbPmdfuASfTdJCuiGrhY95YEFZw34fJZ2chi9eJxETbGWSUQnjkLrs/nP2ROF4R6Ol01Kioj3
	m1TjW7OTujKd+kbDJf4=
X-Received: by 2002:a05:6871:2316:b0:448:558c:d837 with SMTP id
 586e51a60fabf-4586cbb8717mr479845fac.38.1785208920617; Mon, 27 Jul 2026
 20:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
In-Reply-To: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 28 Jul 2026 00:21:38 -0300
X-Gm-Features: AUfX_mzWrjQTB8lo_f1yOAHZ-Zd-6CRFAeENsJ4M1pAoIOVy5YxIU51oRTujI7U
Message-ID: <CAJq09z7QtzTxucEvcKa6zXjhGyuqDjpLHiD8A=EJXshpoV_vvA@mail.gmail.com>
Subject: Re: [hwmon-next PATCH v3 0/4] hwmon: (adt7470) Add PWM provider and
 thermal sensor support
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@us.ibm.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It looks like Sashiko had trouble applying the patchset on top of
hwmon-next. I likely should have used a base commit that's available
across other trees, such as linux-next. I'll double-check whether I
misconfigured the prerequisites (it was my first time using them),
though b4 validated everything fine locally.

In any case, I can resend the series without prerequisites once the
necessary hwmon patches sync to hwmon-next.

Regards,

Luiz
