Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [40.65.178.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E43EC6BF;
	Mon, 27 Jul 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=40.65.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144352; cv=none; b=tHQ9lZqAaT6gmeciDIAOOsdpCrNaAWaY4vHTisC+4W7XkReFPXPc4FR6xP/T3tqGK3H6rnqCHyjnGUQiq/5+G0JtAr+TL0lDgG4ahVxbqYC/0Gw+HY0CCUtjNIxV3BKr4F8H4aETmmMw3ljhyJnNWKX9L98Aa4Mh7CEycMa4A2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144352; c=relaxed/simple;
	bh=uiylSA4Nu6X4+SHpz7bDSOSAcQpQK+/bviQi29qd5LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ReMOVO/qvUVbgITfGWdWcKJTUufMjyJ0dJpikRzeIO6XsDe9rTYsbG9F1ZYTdLsiymmj5ylcAFPKhHNz6Wa0iazP8InENDTUGiXa2B7yKwmOhPvaurMqiBWhIrnbhpW/uWiNsZVpvVsmjl5eFlf9qOpWi0FcDEavztx7FX9XUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=40.65.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 27 Jul 2026 17:25:17 +0800 (GMT+08:00)
Date: Mon, 27 Jul 2026 17:25:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: sashiko-reviews@lists.linux.dev
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	daniel.lezcano@kernel.org, tglx@kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v13 1/5] dt-bindings: pwm: dwc: Document optional
 resets property
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260724085345.E530D1F000E9@smtp.kernel.org>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
 <20260724084304.1531-1-dongxuyang@eswincomputing.com>
 <20260724085345.E530D1F000E9@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <30bf846f.8bcb.19fa2e49479.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA3TJ_9I2dqYEw3AA--.7991W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEBAmpmNx0dB
	wABs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBm
b3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAtIFtNZWRpdW1dIFRoZSB0
aW1lciBiaW5kaW5nIGZvciB0aGUgc2FtZSBoYXJkd2FyZSBmYW1pbHkgKGB0aW1lci9zbnBzLGR3
LWFwYi10aW1lci55YW1sYCkgd2FzIG5vdCB1cGRhdGVkIHRvIHJlZmxlY3QgdGhlIG5ld2x5IGRv
Y3VtZW50ZWQgcmVzZXQgbGluZXMuCj4gLS0KPiAKPiAtLS0gUGF0Y2ggWzFdOiBbUEFUQ0ggdjEz
IDEvNV0gZHQtYmluZGluZ3M6IHB3bTogZHdjOiBEb2N1bWVudCBvcHRpb25hbCByZXNldHMgcHJv
cGVydHkgLS0tCj4gY29tbWl0IDFjMmQzMTM5MTk0OTM4MzhlNjMzNGEyYThiYmQ5MDczMmUyMTdk
YTIKPiBBdXRob3I6IFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVzd2luY29tcHV0aW5nLmNvbT4K
PiAKPiBkdC1iaW5kaW5nczogcHdtOiBkd2M6IERvY3VtZW50IG9wdGlvbmFsIHJlc2V0cyBwcm9w
ZXJ0eQo+IAo+IFRoaXMgY29tbWl0IGFkZHMgdGhlIHJlc2V0cyBhbmQgcmVzZXQtbmFtZXMgcHJv
cGVydGllcyB0byB0aGUgRGVzaWduV2FyZSBQV00KPiBJUCBiaW5kaW5nLiBJdCBkb2N1bWVudHMg
dGhlIGFjdGl2ZS1sb3cgcHJlc2V0biBhbmQgdGltZXJfTl9yZXNldG4gaW5wdXRzIGZvcgo+IHRo
ZSBidXMgYW5kIHRpbWVyIGRvbWFpbnMgcmVzcGVjdGl2ZWx5Lgo+IAo+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vc25wcyxkdy1hcGItdGltZXJz
LXB3bTIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vc25wcyxk
dy1hcGItdGltZXJzLXB3bTIueWFtbAo+ID4gaW5kZXggNzUyM2E4OWExNzczMy4uMWY5ZDcyZjlm
MzU5MCAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
d20vc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbAo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiBA
QCAtNDMsNiArNDMsMTYgQEAgcHJvcGVydGllczoKPiA+ICAgICAgICAtIGNvbnN0OiBidXMKPiA+
ICAgICAgICAtIGNvbnN0OiB0aW1lcgo+ID4gIAo+ID4gKyAgcmVzZXRzOgo+ID4gKyAgICBpdGVt
czoKPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBJbnRlcmZhY2UgYnVzIChwcmVzZXRuKSByZXNl
dAo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBXTSB0aW1lciBsb2dpYyAodGltZXJfTl9yZXNl
dG4pIHJlc2V0Cj4gPiArCj4gPiArICByZXNldC1uYW1lczoKPiA+ICsgICAgaXRlbXM6Cj4gPiAr
ICAgICAgLSBjb25zdDogYnVzCj4gPiArICAgICAgLSBjb25zdDogdGltZXIKPiAKPiBbU2V2ZXJp
dHk6IE1lZGl1bV0KPiBTaG91bGQgdGhlIHN0YW5kYXJkIHRpbWVyIGJpbmRpbmcgZm9yIHRoaXMg
ZXhhY3Qgc2FtZSBoYXJkd2FyZSBtb2R1bGUgYWxzbwo+IGJlIHVwZGF0ZWQgdG8gcmVmbGVjdCB0
aGVzZSB0d28gbmV3bHkgZG9jdW1lbnRlZCByZXNldCBsaW5lcz8KPiAKPiBUaGUgdGltZXIgYmlu
ZGluZyBmb3IgdGhlIHNhbWUgaGFyZHdhcmUgZmFtaWx5IGN1cnJlbnRseSBvbmx5IHNwZWNpZmll
cwo+IGEgc2luZ2xlIHJlc2V0Ogo+IAo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy90aW1lci9zbnBzLGR3LWFwYi10aW1lci55YW1sOgo+ICAgcmVzZXRzOgo+ICAgICBtYXhJdGVt
czogMQo+IAo+IElmIGEgZGV2aWNlIHRyZWUgYXV0aG9yIGFkZHMgdGhlIHNlY29uZCByZXNldCBs
aW5lIHRvIGEgdGltZXIgbm9kZQo+IHJlcHJlc2VudGluZyB0aGlzIElQLCB3aWxsIGl0IGluY29y
cmVjdGx5IGZhaWwgc2NoZW1hIHZhbGlkYXRpb24gYWdhaW5zdAo+IHNucHMsZHctYXBiLXRpbWVy
LnlhbWwgc2luY2UgdGhhdCBmaWxlIGxhY2tzIHJlc2V0LW5hbWVzIGFuZCBjYXBzIG1heEl0ZW1z
Cj4gYXQgMT8KPiAKCkhpIFNhc2hpa28sCgpJbiBwYXRjaCA0LCB0aGUgbnVtYmVyIG9mIHJlc2V0
cyBpbiBzbnBzLGR3LWFwYi10aW1lci55YW1sIGhhcyBhbHJlYWR5wqAKYmVlbiB1cGRhdGVkIGFj
Y29yZGluZ2x5LiBGb3IgdGhlIHRpbWVyIGJpbmRpbmcsIHJlc2V0LW5hbWVzIHNob3VsZMKgCm5v
dCBiZSByZXF1aXJlZC4KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERvbmcKCj4gLS0gCj4gU2FzaGlr
byBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNzI0MDg0
MTUzLjE0NzMtMS1kb25neHV5YW5nQGVzd2luY29tcHV0aW5nLmNvbT9wYXJ0PTEK
