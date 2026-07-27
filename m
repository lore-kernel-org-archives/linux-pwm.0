Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB171E5201;
	Mon, 27 Jul 2026 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144344; cv=none; b=kmL36b/mfjL8IUsyr9LbvGGh+gvuLREj8E44YEC8W6xwGUz0W5P+WUC9ZVJgvZ+EFZZNywgyOB39eJ52GBpwW6l0kDtX04CwKhgSKiw55vKgEc4gOIw7Z8G2wLyuNYhwWP/DpEByaPPYhX/FCw8JWr1uJUy5ZfWHgFxJdmvhkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144344; c=relaxed/simple;
	bh=fV2JsDwf38hqN8P8ne6MErsPoqTydXKrHauT6xdoXC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=f2wPrJGTJ+2mJUgcMdq6StkEi8EPwzZPVuQHvlpPHTKZMl/+B01PXPnDPLKSI76lBw5BSDmntm3AruOW621csnwnzr+ooNOfhm361KrvcbPw1KeaYAwakJIYvC4i3ME4FnRCX53/SIUtjG6EPj37yU5tsB++uchHQ6nEEbwuzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 27 Jul 2026 17:25:27 +0800 (GMT+08:00)
Date: Mon, 27 Jul 2026 17:25:27 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH v13 2/5] dt-bindings: pwm: dwc: Add eswin compatible
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260724085639.A7E841F000E9@smtp.kernel.org>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
 <20260724084320.1586-1-dongxuyang@eswincomputing.com>
 <20260724085639.A7E841F000E9@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <75b02a0d.8bcc.19fa2e4be0f.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA3TJ8HJGdqY0w3AA--.7992W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEBAmpmNx0dB
	wACs+
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBm
b3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAtIFtNZWRpdW1dIFN0cmlj
dCBwb3NpdGlvbmFsIGNvbnN0cmFpbnQgb24gaW5kZXBlbmRlbnQgb3B0aW9uYWwgcmVzZXRzIHBy
ZXZlbnRzIHVzaW5nIG9ubHkgdGhlIHNlY29uZCByZXNldCAoJ3RpbWVyJykuCj4gLS0KPiAKPiAt
LS0gUGF0Y2ggWzJdOiBbUEFUQ0ggdjEzIDIvNV0gZHQtYmluZGluZ3M6IHB3bTogZHdjOiBBZGQg
ZXN3aW4gY29tcGF0aWJsZSAtLS0KPiBjb21taXQgNWFiOTY3YWYxNmMzYjlmN2ExY2ZhODBhYjgy
MzY5ZGQzN2Y4MjQ1Mgo+IEF1dGhvcjogWHV5YW5nIERvbmcgPGRvbmd4dXlhbmdAZXN3aW5jb21w
dXRpbmcuY29tPgo+IAo+IGR0LWJpbmRpbmdzOiBwd206IGR3YzogQWRkIGVzd2luIGNvbXBhdGli
bGUKPiAKPiBUaGlzIGNvbW1pdCBhZGRzIHRoZSBlc3dpbixlaWM3NzAwLXB3bSBjb21wYXRpYmxl
IHN0cmluZyB0byB0aGUgRGVzaWduV2FyZSAKPiBQV00gSVAgYmluZGluZy4gSXQgY29uc3RyYWlu
cyB0aGUgcmVzZXRzIHByb3BlcnR5IGZvciB0aGlzIHNwZWNpZmljIGhhcmR3YXJlIAo+IHZhcmlh
bnQgdG8gZXhhY3RseSBvbmUgY29tYmluZWQgcmVzZXQgbGluZSwgYW5kIG1vZGlmaWVzIHRoZSBi
YXNlIHJlc2V0IAo+IHByb3BlcnRpZXMgdG8gcmVxdWlyZSBhdCBsZWFzdCBvbmUgcmVzZXQuCj4g
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9z
bnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiBpbmRleCAxZjlkNzJm
OWYzNTkwLi5jNjUxNzRlMjA0NWE3IDEwMDY0NAo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3NucHMsZHctYXBiLXRpbWVy
cy1wd20yLnlhbWwKPiBbIC4uLiBdCj4gPiBAQCAtNDQsMTEgKzQzLDEzIEBAIHByb3BlcnRpZXM6
Cj4gPiAgICAgICAgLSBjb25zdDogdGltZXIKPiA+ICAKPiA+ICAgIHJlc2V0czoKPiA+ICsgICAg
bWluSXRlbXM6IDEKPiA+ICAgICAgaXRlbXM6Cj4gPiAgICAgICAgLSBkZXNjcmlwdGlvbjogSW50
ZXJmYWNlIGJ1cyAocHJlc2V0bikgcmVzZXQKPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBQV00g
dGltZXIgbG9naWMgKHRpbWVyX05fcmVzZXRuKSByZXNldAo+ID4gIAo+ID4gICAgcmVzZXQtbmFt
ZXM6Cj4gPiArICAgIG1pbkl0ZW1zOiAxCj4gPiAgICAgIGl0ZW1zOgo+ID4gICAgICAgIC0gY29u
c3Q6IGJ1cwo+ID4gICAgICAgIC0gY29uc3Q6IHRpbWVyCj4gCj4gW1NldmVyaXR5OiBNZWRpdW1d
Cj4gRG9lcyB0aGlzIHN0cmljdCBwb3NpdGlvbmFsIGNvbnN0cmFpbnQgb24gcmVzZXQtbmFtZXMg
cHJldmVudCBhIGdlbmVyaWMKPiBkZXZpY2UgZnJvbSB1c2luZyBvbmx5IHRoZSBzZWNvbmQgcmVz
ZXQ/Cj4gCj4gVGhlIGdlbmVyaWMgY29tcGF0aWJsZSBhbGxvd3MgdXAgdG8gdHdvIGluZGVwZW5k
ZW50IHJlc2V0cywgbWVhbmluZyBhbnkKPiBjb21iaW5hdGlvbiBzaG91bGQgYmUgdmFsaWQuIEhv
d2V2ZXIsIGlmIGEgcGxhdGZvcm0gd2lyZXMgb25seSB0aGUKPiBpbmRlcGVuZGVudCB0aW1lciBy
ZXNldCBhbmQgcHJvdmlkZXMgYSBzaW5nbGUgZWxlbWVudCBhcnJheSB3aXRoIGp1c3QKPiAidGlt
ZXIiLCB0aGUgZHQtc2NoZW1hIHZhbGlkYXRlcyBpdCBzZXF1ZW50aWFsbHkgYWdhaW5zdCB0aGUg
aXRlbXMgbGlzdC4KPiBCZWNhdXNlIGl0IGV4cGVjdHMgdGhlIGZpcnN0IHBvc2l0aW9uIHRvIGJl
ICJidXMiLCBwcm92aWRpbmcganVzdCB0aGUKPiB0aW1lciByZXNldCB3aWxsIHJlc3VsdCBpbiBh
IHZhbGlkYXRpb24gZXJyb3IgZm9yIGFuIG90aGVyd2lzZSB2YWxpZAo+IGhhcmR3YXJlIGNvbmZp
Z3VyYXRpb24uCj4gCgpIaSBTYXNoaWtvLAoKRHJvcCBtaW5JdGVtcyBvZiByZXNldC1uYW1lcyBp
biB0aGUgbmV4dCB2ZXJzaW9uLgoKQmVzdCByZWdhcmRzLApYdXlhbmcgRG9uZwoKPiAtLSAKPiBT
YXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA3
MjQwODQxNTMuMTQ3My0xLWRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tP3BhcnQ9Mgo=
