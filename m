Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415316;
	b=5k2xuYDZPwMboAS/AMF/2CPB/pjTaT4GK5Tra7kkc1663j0+BkIOFDP/7kesd4p9hWcu
	 jinRD980StzKC3ZQ7HK9ZjxbKw7UhQ5raSC3shkQgPte59IQSznMvE0oTm+kuGpIACW4K
	 LS98l0SfAVIPFSh23YqmcAWJOoYTQsBMuHruQyuw8axpeIiGqhkHt6Bo6w77zuArW/u1F
	 wOy/F+s4qsYTzD7qW19xSo3e4zt8kEcqDvlGb5TQ2J8Tj7tUqdFA5p72SKCHevptlo+96
	 EcRP96kmowLm5J1ODS5+FE+xF5QzA99DmduYBF0f8B3lmUacKTwObdmo9S5g/phM2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415316;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uRcMK9bLeuVD4HHBFcWkf9FyslqpUU1bcUKlU/98plA=;
	b=JvPpsoaAE32FWTnZYa/IWbuwAtG3JqPbqqBtFQBm7O1qtF4dlHxIMHOiYg7L/GH9Xwkl
	 UlK7ZjPWlUVbMwQAWMkyYQYxHINhxvbM/nuBbj2zKeMg+2+xdk7H1DdtVSvm4iZ8ETaJO
	 Ite3g+iU8Pt5RUi7Kvd8loLidq9RPaJbcmbJT0joTWT2cuwG/foM9VGtAJZp175sgFopz
	 4PVkdofjwdRLFR4EfE6yMIIbO7Fi9XPiX+ZyvKpKKxgABH8rGNataTIXvI36rlqCcO7Bd
	 29XxY1ebG+eTsfjGQeuiobEORXFjdH/7ZLk7dRvgpmsxjN+LPfK59TTECFiWjSg96fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="U/Bs4Xwo";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YzRWoud2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26978606A321
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26978606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U/Bs4Xwo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YzRWoud2
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN6DbXv1490209
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uRcMK9bLeuVD4HHBFcWkf9
	FyslqpUU1bcUKlU/98plA=; b=U/Bs4XwoW5LDDxb++V8DhQZDLgPrXKdEcMKCh5
	4VNz1QKaIiTYds7fiAQUEqj32lQ6EhzeNGQWhLXqCSu9WuKZd0UQ0Te33ddK7wvL
	4FwOieFRrEM9QEi2TDhIKddT3zwqJL6YZYO5uCqAP69iE3uvYtAGOKoAJTFZAJtm
	Zy0z4yiXBBZluinDXRAJViQFHr7pkLtRO5DUkKHEpT3AcDGwOj74V5q2RDkdYjt8
	8rnxogY9F3nIUuI7Mq0rSwpop51iBUvsIqmhbxP6z7tb8Or6w/dSEYusnZLQwlfZ
	bp5bYpRCaz6L+2cpRGhspcXuGBvNeX50rXGpWsRmxKc53kZw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k01gp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:28:33 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e9eso3665402b6e.3
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 22:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795415313; x=1796020113; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uRcMK9bLeuVD4HHBFcWkf9FyslqpUU1bcUKlU/98plA=;
        b=YzRWoud2q4ZUBiN8Q2ZDnv+WNSZdPp5AQDWyYDaj+Ih2r7z7GBsfCbYb+ZWSDktZFi
         QxJgF54CQHCYyocj1+QgAkXM1Ayn8VLJ3hcT8d7yxG5jUdgn32I09FLoMkkfdOBQZ+mD
         /1Uw/pJ3vphqqwATH1DZ8aVdMz4X4DKnGMb15bV2kuysj+1Ds6nFS4LgSuzS4e3uAzzV
         VG4M6v7gKlDgoq3UX6IB5dGdJiK0+UjgA27oA4/oAfT1Uf6I5uwpQXAk/jaGj94nehNB
         momSYD9MCVM/8DKWL24p7PM8zCjOSHTjwxQ0oaBy9DCQ7NqvYbNuvfG6gCdAkVI/iJSO
         ZlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415313; x=1796020113;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uRcMK9bLeuVD4HHBFcWkf9FyslqpUU1bcUKlU/98plA=;
        b=CqCxA93x/D+NsaQlyqI62OQScW4uGXSKMRrT5rIL/iE0BRPnk7ZnwV85Awk4xCc/9w
         kHE2xtMBxYGpwUaSIlwsYZsi7FrrWwI7I6EW5AnL/0HXRudxdQOo52lH319MCS72dMKt
         wEjSVx2AlgrQLdrtek7g2dkzDhAS2Sh8PBWMPfppKvWuZUbMum16LADWAK9CeOTWaAAm
         a07sFM6RFByjom6xheXf3XmtA3G4eA/JKIyfOmZTx8OJZuC7/Wfsz3PmTOS4eu4k0RBz
         YSPIlZDsr5jSticgDp48+EDtjnlAInJIivKyPCxjkIdusKCUAX3aGWpBAASt0/nsmonh
         EXSQ==
X-Forwarded-Encrypted: i=1; AL+hErEvcUug4BaCpS67Ojzn5340WUX3ePpBqafFH/ieHwICoqLS9Rxv5y+rp8grq/c5LgiCUaxd24+ALmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8skScrBWVodyZH6zGvAoBuoMDnOYIfVOTVmss8emsben636HUA
	OoOL2G6KcQNj8WbavO8hcr8Lqh12zJNKmzsySo7VQgYCQ+w5qMypAnTtlO2vDkLSCiijreMwK+E
	ruszBTiHlqFelBeKEpZEsYx7+kl+KkLZtTJZkdXb5YQiQptjkeecwJbNXOqsiNDE=
X-Gm-Gg: AZFdTZf4DqXaZFBTTrWBUqmdiEWTGsFCzQiJ6HW7iOot509Q7rEeX8rf2/oDcd9ebNZ
	jWJGG29Aaz3VS3BBmLkjvw5zQJg0FWDmjazmvHcuHMsjX+uA3S047LwT/iqqQjT2p9rsFW+NaON
	A/5DXIemmgFayNVTI9faP5JXZBj2t58DVq3EFbt9FMCAJjKESW18wFqz/9bKaHlNn/KLimFAuuS
	8J39tha6QgjVr8+yrxTJGinK7U82adYpDdub8ZeM+t1N36aLZ4W3uh02G+OeczY9AQ/EYoU07bf
	Wj+U0aGJgWGZv2BtwYsyLkcAXpuLzpN5lMqf5HE2dvil3fNFbpt6zMXm/oEo+N8UcAfjzC6c8G0
	IGXPtrK2X2JmP8npbFvXf2kedK2BAYD9PKhBoelHlUx05uGxkPOSAy4Y8xVqUvUN4446+EhDTOV
	RVf6pxo5AH2lQZjTvqm8c7Bft9Xg==
X-Received: by 2002:a05:6808:23c2:b0:4fb:90ae:2b0c with SMTP id 5614622812f47-57a0d704239mr10822283b6e.68.1795415313230;
        Sun, 22 Nov 2026 22:28:33 -0800 (PST)
X-Received: by 2002:a05:6808:23c2:b0:4fb:90ae:2b0c with SMTP id 5614622812f47-57a0d704239mr10822272b6e.68.1795415312818;
        Sun, 22 Nov 2026 22:28:32 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm8762533b6e.17.2026.11.22.22.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:28:32 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH v2 0/4] leds: leds-qcom-lpg: Add several fixes and the PWM
 frequency mode support
Date: Sun, 22 Nov 2026 22:28:06 -0800
Message-Id: <20261122-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v2-0-2e885f60fbeb@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAPbcA2sC/5WOQQ6CMBBFr2K6dkhbENCV9zAsCgxSQ2npAGoId
 7egF3Az+S/5eX8WRug1ErscFuZx1qRtH0AeD6xqVX9H0HVgJrlMheAxdFjDUFmzBQIzdaN2HUK
 jX0ig+hrc00BjgCbnrB8hVjxp8lOV8vLMgtV53LtBeiu+TFP5wGrcZrZGq2m0/r2/NIut91sX2
 d/rswAOmcpTKROe5nFztUTRMKkuSEwUDivWdf0AcHA9VAcBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795415310; l=3917;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=ly029Q7YvH7gRoSmHRIlZeJA+O5qzLwYcxkz4TkvY/A=;
 b=wP6UHfSS952ukLBMm0+DbiBe+z/OwRr+nMDO8VpOnDIVF1IUPKHYaclHIwXa3ZW1GYIT67AYc
 VVZ3yOEh1ZdAbdh4niO4bm5Tv+BqChPBVEr1d/1iCJVQbaN4u2TnjJV
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNSBTYWx0ZWRfX6gpZ8E4rZ+QL
 oKVyuVWn2zZ6S+EprIdbrtwR0Mjz1fkUfnswq4The56v5XUAXIpWSVhPXKsuwBbO0k3onJh9YBk
 zPxlrzFpy3Jc8dG8RvbfCmOfMgWOHRs=
X-Proofpoint-GUID: SGrz04rez7VxJm7xVnS0wpqbX9wunnEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNSBTYWx0ZWRfX0G6GOXtleTFS
 aJVi3rHHss/PO1Xar2fvT251x7bYI4wewWlZAkSpt95t8ja2a7LETIXtVk9HiYBgXWacx21lxeI
 OGoZL+MKhVfPFz7guKrjAtVd64QNCAwQ4SrH1O6wIknfMB4qzF2AdhR0XWbY7pXwekxeM9KUprE
 TYgo3jeIc+48YH1hODKrv8WUm7kLaKWYOk+CR53WtFokh9S9PSp92LgMTw7E7eGuaN2M+gWRIzH
 M4hYsKmA2qvl0rkxUCJQmyf//xtxz6ywjXM7iKhnDlyFr+UkuMef3YHl+5/IC1APNaSzfeRYbeS
 owLrEmIM/rGTD8Nt0hpEsJ9PgIJboCm/xELFYBrrhjneZI1V8WgQvwA6OX6djOA6z1Ilu45VWIo
 +lqgiOMEGk9NeKLjI8TX3/MfoSdb78yHDMwKht4FiN0Iiz/wBQWezJZhhehmoTc3KxXpTsLPkvm
 LpTsQqPidI2FQeTbhEw==
X-Proofpoint-ORIG-GUID: SGrz04rez7VxJm7xVnS0wpqbX9wunnEZ
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b03dd11 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8
 a=ID4R3xiYXese3t_V63AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230025

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
 drivers/leds/rgb/leds-qcom-lpg.c     | 699 ++++++++++++++++++++++++++++++-----
 2 files changed, 623 insertions(+), 85 deletions(-)
---
base-commit: c016466c8c8b01af27ac66d97b64fa9c9e431a3d
change-id: 20261103-led-qcom-leds-multiple-fixes-and-pwm-fm-support-3a04f85c60b9

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

