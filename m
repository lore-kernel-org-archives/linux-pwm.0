Received: from sonic310-14.consmr.mail.bf2.yahoo.com (sonic310-14.consmr.mail.bf2.yahoo.com [74.6.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A53D3481
	for <linux-pwm@vger.kernel.org>; Fri,  9 Oct 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579909; cv=none; b=JSYcq49+LAGSmVHRqiqVvjCwEP0jAyQ7IoDwH4bFljzIWv6AtozS6n9Wxww/9SVUVgVrH4ipI3I0r5FeP4nuI1hOKvGR5Au6Rvo5NBwc55izOgWSb3oKRjhj2coHSaqRP0NCLu8QsFOPhzkDcFUNGGZvRCBkMWqCn2FcTn4i5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579909; c=relaxed/simple;
	bh=xgW/sq4VgvN19Yxx29jLBfotVMhiJArYkAUzEYUolMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ftl2d1LBDa5rhkNPUBjwD6OWHf/N+LrstYbnuvVVvSiAgjBpQjaDjEo83OhmfrhuQjG+dUhHR4nYdFZ3MDfz2ROIYZMllQCOxiMi2ZsiWREJVrXBFBRIavbDtIayy58LS2EkZywCVYBLQ+STibMbZxfnS3D0wJiosUZOYCuU+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gw0eCi5A; arc=none smtp.client-ip=74.6.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gw0eCi5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791579899; bh=xJMjPlMDF/2cqri75QONHmYR6SI/lZUTP25M0BwhfVE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gw0eCi5AVrBMq4tSXhrCuhDMAVkiXQOKrDsC/z2VAKCEei0fIO117raJ+b8Vg4YGiL99qIh5ezYFBMmdYqjqRzLNbP70Emda8MQ2udGB3QsIBOcV0Z2MBmZ0qfMpqBeYG/1uycDczBghWD4LejfmDSPnpc+bVXNbISjQOskUoCICs1cPfgRqkHFiR9Ax5MPqKR1dGqaiDyjQ9puOndTM5ZXR2Vcn82sAJHEnOhXiFWdtsmVyMhDI6KMh3tlsMwpN0j3rcV4XbD8LfNuQq3bHSLPJEiex+HqzhlDqrg6485YXkfpk9j3jWptUXVCxEKOEteeEiZrISVeYSkB5uabXdA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791579899; bh=LcBCK7KjWHKUF/GZb/k7w5DqmGjPpQMxIQQ9r0R4J+K=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=k7Wby1ncwuHW9Pk3zgRa+Vt8ImWbaMQi7/OqIFjXR1Y6n415pO5U0g+xl65SxQA237RBfYRHATXdoVDHxMa6vDn8wsZOmHRffz3CWjUqmN9IpINDUFxJ+36XmyuCZTuNvIFZT/xgAtuzQtkutqo/lSU+6RVK2y6N5DARog8SYQVwv5l/+NwwZBO4ItVFMZ4eN27OGjcoHsu4/YrrbaW/a+He2cNsYE/xmxpFdo14TrgsyaQkfhjFEuiYWyoY3E8CzOc1MWalLX+YG5hJxU4YuKSddWas1MZUdHnTh89flTxj9IaoseXoqIIBxORd79EauK482j7Cc02L7+qi5BOlFQ==
X-YMail-OSG: Dfb6YYMVM1l9ix.W9rjf62ZW7aMx0whnx_R8hKZo0OaGWWpr_RPyWrnHMKecQu.
 EHKjnBwxnACD3LdCKup9dU8rm4Kj1npZun6Lko5yKy0bSLvQ04MkgJUKQrtDZT4CiCZeODp4qWfW
 2_yun2qPCpDxb7LaOM0UROQMoDEtO90Q_pF3E8V4UPbrZK_N6Csgz2Jnuwsk5M7VX9IO89jsYprS
 VfBN0verg4qfpucCd5XgLjGrLzO4eDC0Tmc5MiPirLxvfwBJxSevAgF2U2k25hAGo956VkEnECbJ
 exsMOd5ZoCgBAunBgSusxkoJu2_tg7Q0.2OCpqH5VLDS_QAu_rYmlp5KW59JjA6YoS7ful_3RbbO
 rD5HJWlgVZxUykGxFwj78tdOtwPefGWfdjdaskKzLT0ek0A2DE3VKr3G9dZXdnGzKldQDsdFHAEV
 FP.z0TGjwXEyQqOAJ16J67qBciAJJERIs7BhgPJnXy4s2lsqLcGDEKlEm3kNgwFJS09Jv4IJqrip
 OxEhknVjY7K0Fyy_7tIRFpp7K6KjrO9Vfbb22KkXnbT2YGL96bN9Aa808yt1c4G88dKMRYnKfJdv
 FR9pbiP0ZABt56tdf.6oJpAeZekwuIInSRvzOV4zJf7QsQ1z26rRYeQB7vqx1Uad9ykaDc8P4.rF
 98uECscABmxyZwpzBx6bUh9PFfQWfQK9AJbJgbanxqWMPlEvuBVqQrALl24Q3_Ct0BfmQ0So4vP0
 4bmSUzoor0c8_dBbOe_hv1ahR4laI2uGaKHTc_wBRKcMIjiBIc7dHUgFmdvLe.dQgvRGlmqgwjNM
 4d4kXbC8XDlAQRiPa6MNxzBVJoEwctWI1dT3H_xbTCUutK9VjZefRYKA1RliNzh7b9xs0lzZmfvp
 RyG45rwVALiU3QRxbhSK4JievFXGsaKtufCnE1WlSNHa72mt_I8L4uuHP0J5uz5eM0LmodpNFBEH
 Yx4M6LNPr2UoVbk.CmmUwgW0FLhK.o2S2iNkB.pU1mMn44xEciXFKaTZJqemOuMm8bNNrMxsHxJz
 d9YTb3FsLmnYTlrohNlAITAxHMnII1nnxbuBs7uaZQ0Elgd2k2zMSFV62XI5oyS_T9d443Jto9xb
 SgZQypZi6Qv0W_lBPIJ6FQrG7ZhJLXzuOO5miJenzKvSZq3ddzlqf14duxfBp9rT1w.UixVwc.WM
 hmkuUQI3ogH61niKanX0vb0LSUnOsnw6v1oYQvOYn0.xvuNH.jOOKX86m1rt3mgHuudfnIhPtiHq
 JVxCjtMftpFghVJa0DAtlLjMzpJhBb617BBKdwDuUaEDfvSOCSB.rc4Dvy2lUnjQiyx7DT2j4f5Z
 fJhl0_G2txYMuFcH4WI4k49M.lbYcQk4npV9KafoqCs0sykXbMOdv2eizZdGbUG9R8B4KCB9cvpA
 yObsreCvNiBjumQhIeOfVwgBoElWvfmcABKOFoP_ARFqIlPdMHbz5uUNFqryRiQhW8e_nwmcU9lr
 6kUAUlOFpnpm29h4DsrE3CzFVDWFlkcxgcNQhHK1zUQUsf1YtPQgeDZHisFw5GbOhGqFq3U7CrnT
 vRWHfiDVstpmIgQYMxcaa27jUwlrC0cqcmY1GbSY.Mzakrrl4gl5hE9IV5QGhr3rtozvb37xoO.w
 xwEodvhWLWwPybJzrLLQktJ_vHP4Z6eYAyR.WFUxN6rAuUCrjq4Gdq33.hG3O8z4i.Eknx0FylOD
 e973e3kgSQgQ5SuLlWP4czyh9AFGN6uEWJb9L0czYKvM.DXbTxTQhBzAB5_oIieVYuWsWuYp3evm
 BvhAavXKBffFM1MuB3YoSwdEABzYvex94qdle.6WG6d7SB.lARnM8Q0tmsZa6BY3MRfFjBLErcn3
 uE4Np3nfr.Q.g_x4YYeEiOCCNG2.CFf1q1zul_qUeh_bjF8Tjg2G9Ybb55lmYSnRnJVJpMEBLySC
 dw3AoM8Or9HvN5CRapiPBVPz18_BnQP80TdD2PnfKVaUzacg5UOqFrzYkyPG5qniIVwOYCWk9K9m
 iTiCwc.bmj_gOfwD9kLQ_KguactMEnhdG5av8XdrA2oG6NtMemy..P6fgRVqq4vv6wSuSV0QeY8w
 5Mb10UAW8yKN9LAkp4aH.dDWLEbNOFVNduij6KTdAhyECNGiNEy5ohDQ.wDfktkaDVB2j2HEPwpv
 kf0rLIkNyegMcsjRghhNvNeTO1WSVouxdL4SDLZI3UQtPx_aROrWCCV9wpH6kph8ZEKUMFADD_bQ
 xQkJsPezW3y7evEW7_zSAjbhdQjU2J8jsEQBA
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 30ceb3c1-270f-4259-ad2b-51a28a814d92
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 9 Oct 2026 21:04:59 +0000
Received: by hermes--production-bf1-6d6877594b-qtt2c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 44b417ed8011f4c08f6a2ea9bf8fcbd8;
          Fri, 09 Oct 2026 21:04:55 +0000 (UTC)
Message-ID: <0aabb9f2-a144-4267-b67e-a0972d228f2a@yahoo.com>
Date: Fri, 9 Oct 2026 17:04:49 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: Convert NXP PCA9685 PWM controller to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261006033518.34332-1-deaner92.ref@yahoo.com>
 <20261006033518.34332-1-deaner92@yahoo.com>
 <20261009-industrious-scrupulous-lyrebird-c4fa46@quoll>
Content-Language: en-US
From: Jeremy Clifton <deaner92@yahoo.com>
In-Reply-To: <20261009-industrious-scrupulous-lyrebird-c4fa46@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Krzysztof + all,

Dean is a middle name I use in place of my surname, Clifton, so both
names are mine. I should have used the same one in both places; that
mismatch is my mistake.

The goal was to bring this binding up to par with the rest of the PWM
bindings, so that device trees and overlays using the PCA9685 can be
validated with dtbs_check. It's a common chip in beginner robotics
projects, and the schema means the beginners who run dtbs_check can be
sure their DTS has no mismatches.

For reference, I put together a template for DT schemas:
https://drive.google.com/file/d/183T6W73x45-0WRpo372I1OMeQZop-XzQ/view?usp=drive_link

and a requirements document which could be a starter guide for someone 
putting
together such a schema:
https://drive.google.com/file/d/1K_pfVIZ6u9GjD5tL4TJ40qOHM-_eWe4O/view?usp=sharing

Look out for a v2 with zero hallucination sashiko flags (My middle name 
is Dean).

Jeremy

On 10/9/26 5:36 AM, Krzysztof Kozlowski wrote:
> On Tue, Oct 06, 2026 at 03:35:18AM +0000, Jeremy Dean wrote:
>>
>> Assisted-by: LLM
>> Signed-off-by: Jeremy Dean <deaner92@yahoo.com>
> 
> ...
> 
>> +maintainers:
>> +  - Jeremy Clifton <deaner92@yahoo.com>
> 
> I think we are done on these hallucinations.
> 
> There is little point for beginner contributors to send us DT binding
> conversions generated by LLM.
> 
> Best regards,
> Krzysztof

