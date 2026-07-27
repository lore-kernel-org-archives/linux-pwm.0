Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71113EC6B7;
	Mon, 27 Jul 2026 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144381; cv=none; b=YJzCMlJLjzTEK7qURWPwmBePVAB9XvChVWqvXQqvozReNrNvaK4KJ/DforaLL2zebJcjIC1jTHkLLn7RdIR/SNivRuIfHDZ1n1Leg/o+5u/n60zVxVMCCToBIWCwBs+GfVIcXBJy+9UMB+DFXntKYr4zgj066QOr0qBjMOqTsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144381; c=relaxed/simple;
	bh=oAWSYHh3SNz8lbBplYnJ5xUAd5zZUM2GrrO8n+2zAjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=VxJyRdcsY4eFH1VHZKlCYvrSZXcDlxWelB6dOV0IF5+VxtZ1VHorGH8T0wh/Rbp+MXpi/1IHH0aJa6L7UaDSp6lWGveOrlKHde0C3PulqBiF1qYoAzi+/ldlwU3N4WSsrOvjhfG67xpAWV1hrW885jMOfl2EWTVLxHL0Ip8TeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 27 Jul 2026 17:26:08 +0800 (GMT+08:00)
Date: Mon, 27 Jul 2026 17:26:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	daniel.lezcano@kernel.org, tglx@kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v13 2/5] dt-bindings: pwm: dwc: Add eswin compatible
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260725-lurking-emotional-tarsier-ff05dc@quoll>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
 <20260724084320.1586-1-dongxuyang@eswincomputing.com>
 <20260725-lurking-emotional-tarsier-ff05dc@quoll>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1695d1d8.8bce.19fa2e55d06.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPqEwJGdqakw3AA--.10071W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEBAmpmNx0dB
	wAEs4
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+ICAgIHJlZzoKPiA+ICAgICAgbWF4SXRlbXM6IDEKPiA+IEBAIC00NCwxMSArNDMsMTMgQEAg
cHJvcGVydGllczoKPiA+ICAgICAgICAtIGNvbnN0OiB0aW1lcgo+ID4gCj4gPiAgICByZXNldHM6
Cj4gPiArICAgIG1pbkl0ZW1zOiAxCj4gPiAgICAgIGl0ZW1zOgo+ID4gICAgICAgIC0gZGVzY3Jp
cHRpb246IEludGVyZmFjZSBidXMgKHByZXNldG4pIHJlc2V0Cj4gPiAgICAgICAgLSBkZXNjcmlw
dGlvbjogUFdNIHRpbWVyIGxvZ2ljICh0aW1lcl9OX3Jlc2V0bikgcmVzZXQKPiA+IAo+ID4gICAg
cmVzZXQtbmFtZXM6Cj4gPiArICAgIG1pbkl0ZW1zOiAxCj4gCj4gRHJvcCBtaW5JdGVtcyBpbiBz
dWNoIGNhc2UgLSByZXNldHMgd2l0aCBvbmUgaXRlbSB3b24ndCBiZSBhbGxvd2VkIHRvIGJlCj4g
dXNlZCB3aXRoIHJlc2V0LW5hbWVzCj4gCgpIaSBLcnp5c3p0b2YsCgpXZSB3aWxsIGRyb3AgbWlu
SXRlbXMgb2YgcmVzZXQtbmFtZXMgaW4gdGhlIG5leHQgdmVyc2lvbi4KCj4gPiAgICAgIGl0ZW1z
Ogo+ID4gICAgICAgIC0gY29uc3Q6IGJ1cwo+ID4gICAgICAgIC0gY29uc3Q6IHRpbWVyCj4gPiBA
QCAtNjQsNiArNjUsMjMgQEAgcmVxdWlyZWQ6Cj4gPiAgICAtIGNsb2Nrcwo+ID4gICAgLSBjbG9j
ay1uYW1lcwo+ID4gCj4gPiArYWxsT2Y6Cj4gPiArICAtICRyZWY6IHB3bS55YW1sIwo+ID4gKwo+
ID4gKyAgLSBpZjoKPiA+ICsgICAgICBwcm9wZXJ0aWVzOgo+ID4gKyAgICAgICAgY29tcGF0aWJs
ZToKPiA+ICsgICAgICAgICAgY29udGFpbnM6Cj4gPiArICAgICAgICAgICAgY29uc3Q6IGVzd2lu
LGVpYzc3MDAtcHdtCj4gPiArICAgIHRoZW46Cj4gPiArICAgICAgcHJvcGVydGllczoKPiA+ICsg
ICAgICAgIHJlc2V0czoKPiA+ICsgICAgICAgICAgaXRlbXM6Cj4gPiArICAgICAgICAgICAgLSBk
ZXNjcmlwdGlvbjogQ29tYmluZWQgQVBCIGludGVyZmFjZSBhbmQgdGltZXIgbG9naWMgcmVzZXQK
PiA+ICsgICAgICAgIHJlc2V0LW5hbWVzOiBmYWxzZQo+ID4gKyAgICAgIHJlcXVpcmVkOgo+ID4g
KyAgICAgICAgLSByZXNldHMKPiAKPiBlbHNlOgo+ICAgcHJvcGVydGllczoKPiAgICAgcmVzZXRz
Ogo+ICAgICAgIG1pbkl0ZW1zOiAyCj4gICAgIHJlc2V0LW5hbWVzOgo+ICAgICAgIG1pbkl0ZW1z
OiAyCj4gCgpBZGQgdGhlIGVsc2UgaW4gdGhlIG5leHQgdmVyc2lvbi4KCkJlc3QgcmVnYXJkcywK
WHV5YW5nIERvbmcKCj4gPiArCj4gPiAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlCj4gPiAK
PiA+ICBleGFtcGxlczoKPiA+IEBAIC03NSwzICs5MywxMiBAQCBleGFtcGxlczoKPiAK
