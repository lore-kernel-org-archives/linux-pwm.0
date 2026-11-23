Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417330;
	b=HFzvK2WRQz0wPbXeVp0edpygohfGJTq3HUzKWPzQfUsgo6kWSOOoZznkKP/T3RP81d6G
	 PCFZAyOWuy8FZQG7tgJTVrFTLhFjx9/4fqKFHA8Z9PdVST0Z61cKJD6cN6Yxx4lonE/ZO
	 xFMii78akMoD81Xde1Wd8hKilkVtgvPWzH3mKU7duRow97cJPYveHojvuiYLyUJYXqrTN
	 jpz5meImUM8lf4QtrH2WIw8gXdARsge3tMTu8/DrklS/KVCPBfW+gzLhqnnkJq0kd4i5P
	 ua+T/IHDQMVT4pMQ0DoXUQc/vAQnQKhInd8wgVZnHxnyXLSTO6POi+MJsZhMEinDOhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417330;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WitnkPIKInkmZAEKjbunWxwckrFC20CfZk6oXZK5Seo=;
	b=sDdML2vsIcCnTxlZXFbyiI0gaNE8vkgppA2rdQoPPn+0iJKaQBxl3l/r6RbAkyYv9CgG
	 42XQ1qFvtt0AH9k7lnay187dVewM2SZAbKimGt+6eanuOkV4hiU9tPHfJPZv3eF9gUmMk
	 mhIXHOFu83IRNni/Oj9lO8faoUjPORMJolXLD50shXrVQy+31PsFC7lGpXYV9vjvqCv2M
	 EaOG4tNdpz0l+tkpbhb10oIJfigCZ1zqU/6pc9cSMFEYyIRSIerQV5n7RaKEo9l6m8EQX
	 3EIAr4unMK9tOFztF3zxW3De/C58z2ZnZie06ST+ZF1M/7HVt+hyz2UwhPtFJhHwpaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFvuwKj5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TA8SftVy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D7606A330
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648D7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFvuwKj5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TA8SftVy
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN68wH22372095
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WitnkPIKInkmZAEKjbunWx
	wckrFC20CfZk6oXZK5Seo=; b=oFvuwKj57xx1aV9DriphQI5K5hhtCclZU6K4f3
	0ZSYbkGwww2grANH+q20fu4AJCSd1ctJuHvZOH5rMOJ7cSafdtYmpzHKF1pgoQoD
	aXWgHAYo6ys31XFbuD3sOOIpjJOXFvJVQF4LNa/UqKI+Ub3AemfJbnB/Mpm/quP8
	DY/NmudTK10/n3XlCKsXp30sS1sut1DsMCixL5mjdjGJCthdH6dzycNzAvGSgea/
	QBJ7r/5F1HCSskLaT5riaT4blSpIpSxjlt7dknWCl+aRLmNe+ZhT0/toBU3AUEZ/
	+rwsvj0VPAekn0vh1sN3GrdIF89Ghd0K/PFDQodvQfsEOZYQ==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd065q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 07:02:09 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4ab90cdf747so5075326fac.1
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 23:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795417328; x=1796022128; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WitnkPIKInkmZAEKjbunWxwckrFC20CfZk6oXZK5Seo=;
        b=TA8SftVySvSVWOZixotcDsvqIGLM3WE5UH6Xn1cnOIJMkXsYA2T9D/IXfElXvFEKGH
         hgKpe2641qOm6bK0O7Pv+CD2tEWy+S7L2mupRNtSSkRddg3c7iffg8P5rpJwG11oURBQ
         Mx3ZzfFMHcIAfyZypDVqz136cjSp2Cleuidz5mxL3k0pAY1F2VPAnDe8ilu1TzBoaCTL
         gPE/8MXhD7bYbX1ig83UgpuCWtg1noTTLWyKWoz7SlWepHxC0uKyMUMmQ+Fud2S9Tz/f
         Hu2KJmkumGEj6upIZiekhF8MBRhc8Mm9XggdzenB+kftUzGyVp+43DkXOOwP15N2pqKW
         dtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417328; x=1796022128;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WitnkPIKInkmZAEKjbunWxwckrFC20CfZk6oXZK5Seo=;
        b=YCXTL/bjYcpGoGPLIvvUabP/9ITOADMcYVRS1f0eGaE/AxxbSspDZUTMuFJOCfMJFP
         OhYolz9eDvyJ5nk+S09tP/8tITzyCstuCt+dgig8pew6m4SyF3Kas7Zzk66zOKuEP4CF
         YG7/ifjAD+i1QZ7KHGjbn6uFMHdQHuRbTp0bl4ZtxntniNUGFI7fGRHc5fRGM7tEEZL/
         TPnpYbxqXjMzUA9J/T1wkEG6xqc5tvdGD3b1EsmHwg/+NO/DraDw0uMuOCHHgNmGgiTH
         gXJpWqJ/X2Uf9ngZw+FP9Pe7N3c4+7U2vz6IgRuI9Vp0t0xkFrrs29L+RdE0ExhB8urH
         Bufw==
X-Forwarded-Encrypted: i=1; AL+hErFmnM1AJHija6dZJimDj4R4I4YWhOOzS5Bd0ZpLX/WSmrfGxBKUmg6Vl+1olGo02X6ofDBIG0KdAHs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4eXhvoTZLULDCR6k0mE8h9icFl96HqVe1jOLRxls9syNu1tIc
	obO6M6yZ7FVFZSwOI5uM5i/T20BzqNShABmAO/PhD8pGev0q7zzPRSoJvhcIoEJhs4nue47D7II
	x9flIV9fgcufVlqEytn4TcIuT5Ztj3NFusMD3gNaoeSxlsqL5dL1jYO7VG2AWoUE=
X-Gm-Gg: AZFdTZfE3alfu7vvgoAvoSUcdrlv+YfANeP5RY/6BZlAn+ysTFXaDsby5zZb2k8bVbU
	xDbylKa+uZ0jC+Od74+0xrvxbhOoUB0Vr7fllKrGVvWcWgE2/13nyb+CxoCDG+2lcSau2NCHp7q
	MkcTvs+nGioKr4Up04AZ4YtuSWnAcLrmiwOEyheibzwjo/EoKBlSjvTyeOxWbOioYrTlL5zFnxI
	X5g1MM8B3NIf9r9KI0aVWsQgvHCyIvamlpKtw5TENLTKfxcmRxkLRyAhcpMozpoBMuu59iY3/uQ
	pFKpSqluNorbkcjvOam0QEHx6nTabgmR3wlr3vWBaVlBI1pTqIc9NKof5E4BmPgQqqm4+K5KQXh
	DePMYi3B2vHYik5wrtSUH0JZENNABsQbpIwiymsAHGqaJlDkZDSBPyoIY+u4sx4sPQKle1Wn4PR
	ZMTjoCxCX3+Y/6jlZyFW/rdcTxpw==
X-Received: by 2002:a05:6808:30a2:b0:55b:f88d:6e8e with SMTP id 5614622812f47-57a095fcee6mr7275567b6e.11.1795417328266;
        Sun, 22 Nov 2026 23:02:08 -0800 (PST)
X-Received: by 2002:a05:6808:30a2:b0:55b:f88d:6e8e with SMTP id 5614622812f47-57a095fcee6mr7275543b6e.11.1795417327772;
        Sun, 22 Nov 2026 23:02:07 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm8817213b6e.17.2026.11.22.23.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:02:07 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH v3 0/4] leds: leds-qcom-lpg: Add several fixes and the PWM
 frequency mode support
Date: Sun, 22 Nov 2026 23:02:02 -0800
Message-Id: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v3-0-f911edd40a31@oss.qualcomm.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOrkA2sC/5WOQW7DIBBFrxKx7kQwTgjtqveousD20FAZQxjbb
 RT57oEkiy66yWY0X3r6718EU/bE4m1zEZkWzz6OJTQvG9Ed7fhF4PuSBUrUSskGBurh1MVQH4Y
 wD5NPA4Hzv8Rgxx7STwAXgOeUYp6gsXLnzL7Tsn0VpTVlurGl9OPznnluv6mbqqYSR89TzOfbp
 EVV7mFXh6ftiwIJB2s04k5q07j3yLw9zXYoJWFbjqgjFvyjQXxeg0WDZMzeaelaav/RrOt6BYp
 gQeduAQAA
X-Change-ID: 20261103-led-qcom-leds-multiple-fixes-and-pwm-fm-support-3a04f85c60b9
To: linux-arm-msm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Griffin Kroah-Hartman <griffin@kroah.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795417325; l=4230;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=u4YSFCPdaLrET1dQXhONt7jbw73wkJX2XVbYBBj5P5Y=;
 b=BXlmI3ipv3tifH7OQmvDlsmHTVyZ4L5soz9DId+VftBPU4cyT1QnodhXBeLLtGG8s5zFV92FC
 joaxeWTsuehCkLOOy0Up5gj1cabYoN2hRIO/7pKolVv+KpbVxi1cUWS
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-ORIG-GUID: ZdqGQM8sRgLYFcVOZJSZ1nqFQGNaOvVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfXxq19k0hH6Pha
 462Ozx2TEaRqmgvMzRWtPS/r5RuwcGhum6uGzoeSaXFPAIzZIipwXSK1f9zDN2MQXghHDwtaSng
 A46fHPSk9WycUTSZ3J/gtg1J5aGsUlkYylkyikKEdcRY0cZrz3bS8dQXYbeD8t37SpiQyEfND5t
 k83f/o+72Ldb6GJOt8X0O4TLzTf9enDmPlNrqnyxv/gcJ+krqpn1VoIy3mt0326WLjwfmpXOybK
 csJ+MYTxgXeWy3eWIO5eJxncHOMWxIdjuzsViNZO8dffLv7mIweVl2M8Um6Llhj/TBUIafTNmvU
 IOHZZ2r/Y9JHxwOY22QX/Noi73QJlCda55P4+LZ+jbJuXwG2mqhwao1TbPTfKIB+JZR/L60nzul
 JUabn5hrQCgU5m39z71wADrouEO8g5ajpcmqLVdz1RHHzzrTM75j1QFiXn8Pwgm1FFglbM454en
 2JXpr6KrTbQUVU8tDRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfXy1k8cO5Q5nIW
 Ty+64JPUEr3Jyw9/Jc7bwGGsiUL3jdTmiKcTiN99Fu0WDvQl/pHB3zxT23Nl4SSDReSpL7Q0Im8
 RJM9y7a9s+rIi8d86Ig0FZIJRImGktU=
X-Proofpoint-GUID: ZdqGQM8sRgLYFcVOZJSZ1nqFQGNaOvVP
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b03e4f1 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8
 a=bFXfmCB1GATZPAOclEkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

This series of changes combines and rebased these 2 series as they were
changing the same driver file. It is easier to send them together to handle
the dependency:

https://lore.kernel.org/linux-leds/20260716-lpg-rgb-color-balance-fix-v6-1-b49d51528f61@oss.qualcomm.com/
https://lore.kernel.org/linux-leds/20260827-lpg-pwm-fm-support-v3-1-88ae5208c57b@oss.qualcomm.com/

Also, a new change is added to close the discussion in here:
https://lore.kernel.org/linux-leds/20260827133753.GM770273@google.com/

Following are the Changes in this series after the combination:

- Added changes to scale the pattern when the brightness and
  multi_intensity is updated while the pattern is active.
- Added a new change for explicit LUT ownership tracking to fix single-entry
  LUT leaks during pattern cleanup.
- Skipped LUT allocation for zero-intensity multicolor channels to fix
  comments from Konrad.
- Renamed Frequency Mode identifiers consistently from `fm_*`/`frequency_mode`
  to `freq_mode_*', and clean up the code and fix the naming issues to address
  the review comments from Lee.
- Added logic to compare the timing accuracy between standard pwm mode and
  frequency mode and select the better one.

The change series was tested on Maili QRD device with pmh0101 in these scenarios:
1. Tested the RGB LEDs by randomly adjusting the brightness, hw_pattern, and
   multi_intensity when it is working in HW pattern mode, and the LED pattern
   and color were confirmed to update correctly every time.
2. Exercised the PWM4 channel on pmh0101 by requesting it at different periods
   with a 50% duty cycle, confirming that the frequency mode could be configured
   correctly.
 

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Changes in v3:
- Fixed the review comments from Sashiko
  1. Avoid ping-pong compression for two-step patterns to prevent programming
     an unsafe single-entry LUT range.

- Link to v2: https://patch.msgid.link/20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v2-0-2e885f60fbeb@oss.qualcomm.com

Changes in v2:
- Fixed the review comments from Sashiko
  1. Replace the ``pattern_lo_idx == chan->pattern_hi_idx`` checks with the
     ``has_lut`` flag, which is also used when releasing LUT allocations.
     This correctly distinguishes a valid single-entry LUT from a channel
     without a LUT.

  2. In ``lpg_pattern_mc_update()``, scale multicolor patterns using each
     sub-LED’s calculated ``brightness`` rather than its ``intensity``.
     Document the resulting multicolor pattern-scaling behavior following
     feedback from an OpenAI-assisted review.

  3. Add a LUT allocation preflight in ``lpg_pattern_mc_update()`` to ensure
     the complete replacement pattern fits in the LUT before stopping and
     releasing the existing pattern.

  4. Stop recalculating sub-LED brightness using LED_FULL in ``lpg_pattern_mc_set()``.
     Scale the pattern using the existing calculated sub-LED brightness instead.

  5. Update patch 3/4 commit message to clarify that the lock in lpg_pwm_get_state()
     serializes register reads against register writes performed by the LED
     callbacks.

  6. In ``lpg_apply_freq_mode()``, preserve the PWM_FM_ENABLE bit when
     disabling a channel so that a subsequent get_state() call can still
     report the correct period and duty cycle.

- Link to v1: https://patch.msgid.link/20261117-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v1-0-7a862240683f@oss.qualcomm.com

---
Fenglin Wu (4):
      leds: rgb: leds-qcom-lpg: Fix single-entry LUT leak
      leds: rgb: leds-qcom-lpg: Fix LED color balancing in HW pattern mode
      leds: rgb: leds-qcom-lpg: Add mutex lock in lpg_pwm_get_state()
      leds: rgb: leds-qcom-lpg: Add PWM frequency mode support

 Documentation/leds/leds-qcom-lpg.rst |   9 +
 drivers/leds/rgb/leds-qcom-lpg.c     | 701 ++++++++++++++++++++++++++++++-----
 2 files changed, 624 insertions(+), 86 deletions(-)
---
base-commit: c016466c8c8b01af27ac66d97b64fa9c9e431a3d
change-id: 20261103-led-qcom-leds-multiple-fixes-and-pwm-fm-support-3a04f85c60b9

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

