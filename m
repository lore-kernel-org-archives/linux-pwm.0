Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BD199D8;
	Fri, 17 Apr 2026 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395646; cv=none; b=sPxKXvjj5x2zwedxp1arwjdZ3xNmtbQahCYw30V3oJYRcPIYn8BLj8yZwNNrjw2oYwb+r3UOr4wL0vJhUt33rE4AaTbdq/4+R7yxy7If5IDzfc5+LnDZQ51bwR8Q3HjRe8Qv2DSPv+CmZChrYE4QCswg+CwZ6iOj+cUowG4w3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395646; c=relaxed/simple;
	bh=XlKAvBAxYI1INKbsNGmDVyjKLC/0zmoT5vwxHS3s6O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=knZKfmll9PIXFHnSde5wyP/v4FsnFPUgF2qbDXnYsYB11tdvPINoIJ3Qau73znImO/QK1gUimIHzLbOvazjEG8PJDIyGicofxzyc9QpeaoZOtRBT3EIPOURKDIzjheknTKBGxd9w+DhV8YC1NIfCPE+e+z3sePFeO2qirKCDscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 17 Apr 2026 11:13:52 +0800 (GMT+08:00)
Date: Fri, 17 Apr 2026 11:13:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aeE-D5vC453uqtm6@monoceros>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
 <aeE-D5vC453uqtm6@monoceros>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <65568985.55a7.19d996e40c9.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPqFwpeFp31YSAA--.4352W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEAAmnhD40Rb
	QABs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBIZWxsbywKPiAKPiBJIHN1Z2dlc3QKPiAKPiAJZHQtYmluZGluZ3M6IHB3bTogZHdjOiBB
ZGQgb3B0aW9uYWwgcmVzZXQKPiAKPiBhcyBzaG9ydGxvZy4KPiAKCkhpIFV3ZSwKClRoYW5rcywg
SSdsbCBhZGRyZXNzIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4KCkJlc3QgcmVnYXJkcywKWHV5
YW5nIERvbmcK
