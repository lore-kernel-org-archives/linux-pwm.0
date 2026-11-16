Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812929;
	b=mn+atlfQs02896JyrCKt/C0sdhz6ILLD20tbcuFWY2z6VM2BtaG/qnTdWansG9/ebZQn
	 ipFurx/2mGtv3+dlRqDGSkimRQlpAd6FWbgQmb05AMkgsyqEzIHzoJg+n5l8T2NzAV+vE
	 SAZLk9bFRpjKMKslaDoC6xkHpzvumn91TIDADzDXUR6QpkWA73hW7R8YYYp3pBS1KhiK+
	 MFJrYsEXh5aCd2LqwT5e1cbk7OvmQtH204Neb1CqVPt0EaAv2N6q1xeysgb5o8qB6tswd
	 w1stFXTJmprJTPB2N3wlCgc6LMW8QAs5GXQu3bwd3eBNHyMsYbxLDz3Fh84oMvuQztg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812929;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VsctoSyuzeDFyOLJHRFtf5FpkehAfPMSRea91fkgfbs=;
	b=XXOoOoTeJ9K88HdjlqKeo6H1wkuGtXLf71X/qB1srvX4556v1eXtH+2QBUhyXQ5z4NSm
	 XnHCJu5xzNMqgNuicITPt4IHdCBRQQSoXcYXLZ28M27ozY0+GXeAfbmOU00fhPACKaSZS
	 3qPm+0KnYmA7MQoHHUmq/Cb7CaMqt5E45x25cDPELLL/1ggdrCLGkBzRYsFremK6x/X1q
	 b8abnlHKRDhcCGOrKjC/QsSiaReKLhE1BBPuo5Bd00rRekYbZ+oVfrYDyWnVPkjBSV1om
	 0zQLRnGwwInMHLnkVsDS3ODwnmIS0SQOP9Dwpt1ayQZU+MhRorP0wwckvHRIPauGkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UU+lkmg8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LI1lEujG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC48606A323
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBC48606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UU+lkmg8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LI1lEujG
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG5LotE323082
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VsctoSyuzeDFyOLJHRFtf5
	FpkehAfPMSRea91fkgfbs=; b=UU+lkmg8mKbhrhmA1XaI+i9P9IE1ak1bAcJpyo
	ZMiNibS2UNDUIHc99dFfWj/bO8F7SYN3Zts60vd9qgevheLue2niTouNQqrDQbVd
	Z5UuSdYXbMgVx3bmioBuPqS1W/37Lf6DiCL0NJ2CUpMY+tSCnxf2dVXF1Vhs/IFN
	i1BvYS/mZO7Yu6oAsdBqHm02V5k7T+0bUmFwHGbIrgKYwaXDsJToG4OJeNXovLnl
	aSQ3URKryJvs64POzafE+87Rsd0JwrlMs8ZCF3BwibYgDZGWcb9cvOia6o4ypZnz
	9YfUxb4QqHpZD8rKa0rx85oLzCwqmKKxVzge2dSoEmcRTeDA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx5c02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:08:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0e00d7cc2so2824089a91.1
        for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 23:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794812926; x=1795417726; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VsctoSyuzeDFyOLJHRFtf5FpkehAfPMSRea91fkgfbs=;
        b=LI1lEujGGe1Lpa6zJ0gKOLH8EsGxNBR4X7IrmAczkLxzZhEml4cDItkRbHgqhFf7Ab
         mhIZCnGnp4C4WCnauY6xATLNQXYF4wrz8KKNzOWBte7yec0eI2W2/89x42+nNYfxNxsF
         Sa9gn0N65yMiIsQNA9BN0zMrMT9tEDg2WGo7lfyYl2teRgxxM3YL52ALIJfdcjkVXPuh
         fsWAHcGddEUtgObJev6q8A8P3sQXgY7ZMYonO1RUrtaxBZhEpXhoXp1lnJ5z6CBm7Aha
         mgZQb5JzxkqI7AmooDglDJF30dsaCiZqYCsE9haetmEq74HT/tIpsICXrEa8saf2tkqF
         FXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812926; x=1795417726;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VsctoSyuzeDFyOLJHRFtf5FpkehAfPMSRea91fkgfbs=;
        b=mymK1wTrp+nJWpiBORQvLZ419CWoT03KN3sAd7O3CDvIQg6OL10XcmgoyCqGFV6uHY
         4a2kp2K8+qEOgXoLE6mfwNPcH+3Xx1hiZYjpHCHQ3U8f54cElHoB4VEt/wM+uSf5WjpQ
         HMfokNj+5xwL+ateTWcPVnaGLqfCQRgnwtytgDSaOIz2fP01kKNKrecietA8EO6PslQR
         DHxQ3aqh8l86D9tH7+xQ0ib0kItwYx2tS5rPBiZmJFuyD5s0/C6QXjOhqESanXU2q3WM
         Kw2dHRJ58y+BOh7lVrvHkCNVXo4TtlIEMYlp3VxIfDyq4JG3G7YugLCEDk6Mt18RrzhW
         f20A==
X-Forwarded-Encrypted: i=1; AL+hErEhWSoE77UUxb0c9KGlLD4Tb0zVWbAS8xlcprjMgX6gEkc/+6zZzQSGSsYVRlZxsMHm8/9yB7zS77U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WlL7wd5V2L0UPb3Mo06cd4GM9cpStk3BvePFYFQ2tAgf5CgnA
	mCIhBvYoVB3iau+/uYbdEGQOrN3I+2CPUb7Gh8iUp+svogrq5W4ImbSovU1/qcD/bSYRiYSr1zw
	VBJuDgGQKCiFSmzGF8pbv6KCeGhvgWoENDO4lWsdTrWkCg1IQtd0k2JhhRypE434=
X-Gm-Gg: AZFdTZeMOTC18zFJMSJUW2wLXKPPq/cDprq/AmfcAF9bIMT64eFzarP1g28XSunzcMJ
	itg/xLBXbiAE1AD7nL1h2KJ2sjVHOAEgf3sof8xP1iuF2Ta6IE8jVy4a0Xvid/fmxifKJYumY4T
	dmYFpMvVpKdkM1dXaa3pFKUORUttZWNZu7VgXH4cv0EW3Cc4xZpwdxRXJHIeAywT4cmS12TeXBD
	lpfC7FHbTiXqDYghRnrcPTKPYf5SgMdg1UfVgD7/cpEl9lgahVvG+bbpJAVIFFE5vIcXzJBKU6p
	XnNWRxYMflp276SWPPqfH5h8hVYb2nkhquMSa0pekgMUpi5yQ55UlZ0sO+6UrkmzpwZgYP2CS5T
	+9RPDsWJEoRi2LexDM0Q7iYVT9Is+Fq/BU0NDk5qstmox85hlKt0ZhBm+uHeM7GpKyF3gLYCcOw
	==
X-Received: by 2002:a17:90b:2f0c:b0:3b1:8300:f48e with SMTP id 98e67ed59e1d1-3b1b0b89c42mr8804480a91.49.1794812926500;
        Sun, 15 Nov 2026 23:08:46 -0800 (PST)
X-Received: by 2002:a17:90b:2f0c:b0:3b1:8300:f48e with SMTP id 98e67ed59e1d1-3b1b0b89c42mr8804451a91.49.1794812926018;
        Sun, 15 Nov 2026 23:08:46 -0800 (PST)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm8658667a91.0.2026.11.15.23.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:08:45 -0800 (PST)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH 0/3] pwm: qcom: add Shikra PWM controller
Date: Mon, 16 Nov 2026 12:29:47 +0530
Message-Id: <20261116-pwm_qcom_shikra-v1-0-67ee4553adc5@oss.qualcomm.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOp+moC/1WN2wrCMBBEf6Xk2Ug3bdILIv6HiGziRoPW2myrg
 vjvRsUHXwbOwJx5CKYYiEWbPUSka+DQnxPALBPugOc9ybBLLFSuDAAYebl128H13ZYP4RhRoim
 0MtbjTjUirS6RfLh/jOvNlyMNUxKP31J0xIwfcZst/rzu1Lsj/8xXkLnU2jsAnUOtYNUzz4cJT
 +m+m6dYvg8tMsl3E8Y2q0u0ttHaQg66rCpEAGwMKV+gA9sUta0qX9Zi83y+AOJqPUf8AAAA
X-Change-ID: 20261116-pwm_qcom_shikra-a63526bfad29
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfXxwn02FILbav4
 YHmbXgFqB5U0LHVO0KyY7kPrhvlDva3IlH/bdAniwkBKA0vXJak8NkC6OPZKsYxxzAammIwfU8f
 ExoAre2HgdqhsB1p+WdDTlQru/Pvzw13Zm5F6VOkgv2oBpoFTtvvN6G6jG52Lg7fE1Lm8d3cbMS
 DWOAdtf+1z+JHe51+Kze7cOqiRnzxZ5cydDQxaCXbM3o3kHIFH0+5upvHkA/AZhPzhqoiGRdYBR
 2fGHzskrR+0+EtL7YmyTmeXD6uHezqBKWYKYj+G8duB2avyE0JLOjJlx5rxr60/gXqCY0gpH0iP
 2dxcKDEePehwbxRkIUvo7eYlGj/sovM5XzQ4NejGwuLXuNSVIKtge/+YaEGqJD/5GkyK+gCWpXU
 CDMypkBc27iV2OG2B5qYjXUrhtI/mnoSML9BiXNdAqwB0TXW7s45Tzn3zE17/C4lTGKYQ+8NS11
 nTtyeOOi/Zqmm5oUg9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfXwClgC8seEBR8
 Bpv6yG3zExZK7IMfCaa7edJX5JJCDvTkd+MOKvR1fnkG/12SHr2BFxa+OFX7aEktcwBIULiVij7
 SqPzkLyFOTWUMBkihp/Ot2pBMeK+WtI=
X-Proofpoint-ORIG-GUID: q0QfufOuqSSeEygJj4DJWR-zXDfGy0tn
X-Proofpoint-GUID: q0QfufOuqSSeEygJj4DJWR-zXDfGy0tn
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6afaabff cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T5qpfgZGmVIljgUINK8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160028

Add support for the Pulse Width Modulation (PWM) controller found on
Qualcomm Shikra SoCs.

The controller exposes a shared output-enable register and up to ten
independently addressed PWM frame blocks, each modelled from its own
device-tree child node. The driver retains the shared AHB and PWM core
clocks while any output is active.

The series contains the device-tree binding, the driver, and the Shikra
SoC DTSI node describing the controller and its ten PWM frames.

This series depends on the GCC PWM XO512 source clock, which provides the
GCC_PWM0_XO512_CLK_SRC divider feeding the PWM core clock referenced by
the controller node:

https://lore.kernel.org/r/20261116-pwm_clocks_shikra-v1-0-55fc11501821@oss.qualcomm.com

---
Taniya Das (3):
      dt-bindings: pwm: qcom: add Shikra PWM controller
      pwm: qcom: add Shikra PWM controller support
      arm64: dts: qcom: add Shikra PWM controller

 .../devicetree/bindings/pwm/qcom,shikra-pwm.yaml   | 127 ++++
 arch/arm64/boot/dts/qcom/shikra.dtsi               |  63 ++
 drivers/pwm/Kconfig                                |  13 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-qcom.c                             | 685 +++++++++++++++++++++
 5 files changed, 889 insertions(+)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261116-pwm_qcom_shikra-a63526bfad29
prerequisite-message-id: <20261116-pwm_clocks_shikra-v1-0-55fc11501821@oss.qualcomm.com>
prerequisite-patch-id: 25c90a2ea712aecae7404104dcc83e1c79227b6c
prerequisite-patch-id: e4b3500eec0cf6bc98edc43780b2828c28445b5c

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>

