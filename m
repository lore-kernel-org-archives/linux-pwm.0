Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6843C109D;
	Wed, 10 Jun 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083549; cv=none; b=brQ3Wld6bBZx8H7jDVTu+fjnhgK1+DN6Rcu+8NVa4+pPst214RhbzwXiU4/O21wkSt9zzzoiYqYJzONDjqlmI8tks/tH8sLDbjDPBeh27HIzAcaG4mS8V+yYXylWaI5HVGYOVvdAOARR7uXwTiHtnpZDim1NSETiT8gtTGMM4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083549; c=relaxed/simple;
	bh=hTh8Z4WzJirzBjWW9JmGHvJTie+/I/fSkwcPwxv2iTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=D9Dc6khtWeNi6BgvhYFRB+S0EjC4biLQkEF6u/rHQzM00+dldg+rS8Em1HXzwq28HQVG0Uer7CAnnLxFSWONuo/SR29sYo9gTfCOG0Bj8X3aKW6chWhXGV9PlCmzdcZd1iIU651JsNzu10NHIvKp/9UnL5XsyGVSoY8YlhZCEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Wed, 10 Jun 2026 17:25:20 +0800 (GMT+08:00)
Date: Wed, 10 Jun 2026 17:25:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v7 1/2] dt-bindings: pwm: dwc: Add eswin compatible
 and resets property
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <c4fa85f1-365e-49ab-9549-d6d46529a68b@kernel.org>
References: <20260605082242.1541-1-dongxuyang@eswincomputing.com>
 <20260605082318.1599-1-dongxuyang@eswincomputing.com>
 <20260605-scrupulous-tasteful-nuthatch-5d8ce3@quoll>
 <643f9b98.722f.19eabb8fe3e.Coremail.dongxuyang@eswincomputing.com>
 <c4fa85f1-365e-49ab-9549-d6d46529a68b@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <25b0baf0.731a.19eb0d9bf07.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA3TJ+ALSlqTM4lAA--.5583W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEOAmooQJYbE
	gAAsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBPbiAwOS8wNi8yMDI2IDExOjMxLCBYdXlhbmcgRG9uZyB3cm90ZToKPiA+Pj4KPiA+Pj4g
RUlDNzcwMCB1c2UgRGVzaWduV2FyZSBJUCBmb3IgUFdNIGNvbnRyb2xsZXJzLiBBZGQgRVNXSU4g
RUlDNzcwMCBzdXBwb3J0Cj4gPj4+IGluIHNucHMsZHctYXBiLXRpbWVycy1wd20yLnlhbWwuCj4g
Pj4+Cj4gPj4+IFRoZSBEZXNpZ25XYXJlIFBXTSBpbmNsdWRlcyBzZXBhcmF0ZSByZXNldCBzaWdu
YWxzIGRlZGljYXRlZCB0byBlYWNoIGNsb2NrCj4gPj4+IGRvbWFpbjoKPiA+Pj4gVGhlIHByZXNl
dG4gc2lnbmFsIHJlc2V0cyBsb2dpYyBpbiBwY2xrIGRvbWFpbi4KPiA+Pj4gVGhlIHRpbWVyX05f
cmVzZXRuIHNpZ25hbCByZXNldHMgbG9naWMgaW4gdGhlIHRpbWVyX05fY2xrIGRvbWFpbi4KPiA+
Pj4gVGhlIHJlc2V0cyBhcmUgYWN0aXZlLWxvdy4KPiA+Pj4KPiA+Pj4gVGhlIGdlbmVyaWMgc25w
cyxkdy1hcGItdGltZXJzLXB3bTIgYmluZGluZyBhbGxvd3Mgb25lIG9yIHR3byBvcHRpb25hbAo+
ID4+Cj4gPj4gSSBkb24ndCBrbm93IHdoYXQgaXMgdGhlIGdlbmVyaWMgYmluZGluZywgYnV0IGl0
IGRvZXMgbm90IGFsbG93LiBPcGVuCj4gPj4gdGhlIGZpbGU6IHRoZXJlIGFyZSBubyByZXNldHMg
YXQgYWxsLCBzbyBpdCBkb2VzIG5vdCBhbGxvdyB0aGVtLiBPciB5b3UKPiA+PiBtaXhlZCB0ZW5z
ZXMgaGVyZSBhbmQgeW91IHdhbnRlZCB0byBkZXNjcmliZSB0aGUgY2hhbmdlPwo+ID4+Cj4gPiAK
PiA+IEhpIEtyenlzenRvZiwKPiA+IAo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCB0
aW1lLgo+ID4gCj4gPiBSZWdhcmRpbmcgc25wcyxkdy1hcGItdGltZXJzLXB3bTIsIHdlIHByZXZp
b3VzbHkgaW50ZW5kZWQgdG8gYWRkIHRoZcKgCj4gPiByZXNldHMgcHJvcGVydHkgaW4gdGhlIHNh
bWUgcGF0Y2guwqAKPiA+IEhvd2V2ZXIsIGFzIHlvdSBzdWdnZXN0ZWQsIHdlIHdpbGwgc3BsaXQg
aXQgaW50byBhIHNlcGFyYXRlIHBhdGNoLgo+IAo+IEkgZmluZCBjb21taXQgbXNnIHN0aWxsIGNv
bmZ1c2luZy4gUGxlYXNlIGFsd2F5cyBjbGVhcmx5IGV4cGxhaW4gV0hZIHlvdQo+IGFyZSBkb2lu
ZyBjaGFuZ2VzLgo+IAoKSGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLgoK
QWNjb3JkaW5nIHRvIHRoZSBEZXNpZ25XYXJlIElQIGZvciBQV00gY29udHJvbGxlcnMgbWFudWFs
LCBpdCBzZWVtcyB0byBtZcKgCnRoYXQgQmVuJ3MgcHJldmlvdXMgc3VibWlzc2lvbiBtYXkgaGF2
ZSBtaXNzZWQgdGhlIG9wdGlvbmFsIHJlc2V0cyBwcm9wZXJ0eS4KClRoZXJlZm9yZSwgSSB3b3Vs
ZCBsaWtlIHRvIGNvbmZpcm06IHNob3VsZCBJIHN1Ym1pdCBhIHNlcGFyYXRlIGZpeCBwYXRjaCBm
b3IKdGhlIHJlc2V0cyBwcm9wZXJ0eSwgb3IgaW5jbHVkZSBpdCBhcyBhIGZlYXR1cmUgcGF0Y2gg
aW4gdGhpcyBzZXJpZXM/CgpCZXN0IHJlZ2FyZHMsClh1eWFuZyBEb25nCg==
