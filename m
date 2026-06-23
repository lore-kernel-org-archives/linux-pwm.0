Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227F30216D
	for <linux-pwm@vger.kernel.org>; Tue, 23 Jun 2026 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224201; cv=none; b=B7PHBdzgV2fmOa3SeQmhokL80nwoFtVgE4Co7D2AYIjdNgKiak/LUB6iAAyv4dSJMtLsWSOqqrtoAwhYmTQIPZwp8qKt7149w4oqbB2Z6K1iG1bocCMqE3x4t+El4BNClSYEj9UZNCoXU/LlxXEgipGjLPWYfecCzSGyMi3Vvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224201; c=relaxed/simple;
	bh=tUrRzAy9axz+ACESZYkPXNYcDTB4b3V9V30KZ9JrMWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOeGQTxt3h99UJiC/HjGzU7D1YqpNXNFAPZDOs63i087FYXBnVXooJU2SI+16roI46T8a1BrZRLA8vYUhBI23ult9Esef+A5lSzJrkU3Ce2sOko1l590cYKnm0eMEkxXDFQprOn39lF/0cw4sf6/csLE9nin7j5+EX8fkHel0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4XbcUyu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4XbcUyu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c40397e3caso54643055ad.2
        for <linux-pwm@vger.kernel.org>; Tue, 23 Jun 2026 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224200; x=1782829000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5jyDpTw+nbmVl4evKwREMIxAz2iLdO/axx6qTM+O1Q=;
        b=B4XbcUyutakW4uYHwA9baO3I44hX9qJcZniAhxFN+PVW+iglYNJpbtCeSTmSWstL6z
         cKYlEK7+k1M3LK2TQ7ZmtL7+R5fbCvhS2gSiBobhMIbYwYJYzZivVfz2dzSFIC8rgNpx
         sQWJmoo3s6+ZgLGsVX1KOyaUOmEfxivu0uu8yV2px3VuDCrJ8+UpVKGoZptQF46VtZ3z
         WKuPcGoWV/DkvcyA3y7j8GzOPwzC0HKMiKRgOlfN+dFkNeI2/798Ra9+J//FvTw10tFW
         V7auUN7GVh9rPARdyGYu6IfopQhcFcfe1kkWiWXq/AFGfggdbA12N02wxEZRL0Lg0FLA
         Xyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224200; x=1782829000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5jyDpTw+nbmVl4evKwREMIxAz2iLdO/axx6qTM+O1Q=;
        b=lh1Dq/OWiiSa5Eho7ybv+T67fwsJd3uHt1uxYXKeTx9j/6PeeI0J1RowWSy/6WR/OB
         34obtTM5KNIT/Bk4pUWvPgJm6V+tgLfEWYAihXZ/hSqZhfShsU930dH4t9KGEmhc6XTX
         9pf3pq6i4bW/QsCsqbAWqzYrPzQiTQuiAnobvDXvPnX9EtPvlE0/M1snHjGkG+48jfQj
         WyV0p2SRzQXpqiBLMp6592tN8IbT5gtUeZm6ynSC35zcOHRPtaKKU2zduODeersBactK
         RUGd6DPFi0TivbHYgNgkENqxegAYUkxokI8J5l7JVOV8CYvc7mPMFs3OUGsrdq3TpvaQ
         NvoA==
X-Forwarded-Encrypted: i=1; AHgh+RqAjr6+YmYEuz3aNTQpKPvSTc/qoaxbOxVZPZWQOBdeaV80BKqGXJVjUKWsoazOs8Fi5eSDAdqHNQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPV4p6YTruCzuFNcT+txqGILNa/xdd9DL/YP3/Xb3dSGZSXikn
	rOiKl0hw6ZVu6PmdjHwa2Na+GrNJRfn1UOaj5Gscij8WkY5ezooXxdLW
X-Gm-Gg: AfdE7cnQLNj4LpnalASjTtjiiuT6mrHya2YFpDlVbOvef93B8Ld1MhkwizPdjb8bduw
	2RuTJRLap6A0rFEQYcjI+IFIoRBvjyPy8k8M7BNwWG9QbDccdyHwCXWxu7lSoQ4VMlFVeMpxTYH
	vHsCtO96SYXyEP/bRz1bYEJ98f7Kpq/hll4gM01ZnwTzQQb2Subp6j5cvgsKjub339rqHEhTgBL
	+alQXsOvJUjIm2esf4SMvJ8cIgzHGKZc6r51OBQmeEDkXg9ANianCH5zJQ0Dtbj2YGPDAKZYTGy
	bAMm/QtRQMZqX8B9ux5DWbEVbd+HdWK9Bdk/f7owqM3GbUHAYbIFfFdu/WwRnHKrpDEbQIIa+zB
	rNykH3qirKthjZQmWueM9UH/Hm7GNgWajLkNZeUDh3C88fPBm09XQPi0BAJY0yv+g8aADLN9shU
	yulOfnAFShnsfOaST+/yvmCVF5uhI46C66ClY=
X-Received: by 2002:a17:902:e5d1:b0:2c0:cf44:3b3b with SMTP id d9443c01a7336-2c7c7684655mr32613395ad.24.1782224200074;
        Tue, 23 Jun 2026 07:16:40 -0700 (PDT)
Received: from [192.168.0.2] ([49.207.62.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f6395sm112363965ad.28.2026.06.23.07.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 07:16:39 -0700 (PDT)
Message-ID: <464e09d2-5a8f-42ea-998a-42cf1376a6e7@gmail.com>
Date: Tue, 23 Jun 2026 19:46:35 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pwm: st,pwm: convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pal Singh <ajitpal.singh@st.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260618-st-pwm-v2-1-c792d5795ce2@gmail.com>
 <20260623-electric-adder-of-upgrade-8bdeb4@quoll>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20260623-electric-adder-of-upgrade-8bdeb4@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23-06-2026 12:47, Krzysztof Kozlowski wrote:
> On Thu, Jun 18, 2026 at 12:42:07PM +0000, Charan Pedumuru wrote:
>> +description:
>> +  The STiH41x PWM controller supports both PWM output and input capture
>> +  functionality. It provides multiple PWM output channels for generating
>> +  variable duty-cycle waveforms, and multiple input capture channels for
>> +  measuring external signal periods and pulse widths. PWM output channels
>> +  and input capture channels are configured independently via
>> +  st,pwm-num-chan and st,capture-num-chan respectively.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
> 
> Where is this compatible used?

I will remove this allof and redefine the YAML again

> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Charan.

