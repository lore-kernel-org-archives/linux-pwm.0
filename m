From: David Wu <david.wu@rock-chips.com>
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Date: Wed, 3 Jun 2020 11:10:26 +0800
Message-ID: <2f860dba-26c7-c670-58e2-9ef502881522@rock-chips.com>
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
 <20200602123914.GA3360525@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200602123914.GA3360525@ulmo>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

VGhpcyBjaGFuZ2UgaXMgdmVyeSBnb29kLCB0aGFuayB5b3UuIFRoZSBjb2RlIGNvbnRpbnVlcyBm
cm9tIHRoZSAKb3JpZ2luYWwgY29kZShnZXRfc3RhdGVfdjEgYW5kIGdldF9zdGF0ZV92MiksIGRp
ZG7igJl0IG1ha2UgYW55IGNoYW5nZXMgYXQgCnRoYXQgdGltZSwgYW5kIHNvcnJ5IEkgaGF2ZSBu
b3Qgc2VlbiBsaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnIAptYWlsIHJlY2VudGx5
LgoK5ZyoIDIwMjAvNi8yIOS4i+WNiDg6MzksIFRoaWVycnkgUmVkaW5nIOWGmemBkzoKPiBPbiBU
aHUsIFNlcCAxOSwgMjAxOSBhdCAxMToxNzoyN0FNICswMjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdy
b3RlOgo+PiBUaGUgd2F5IHN0YXRlLT5lbmFibGVkIGlzIGNvbXB1dGVkIGlzIHJhdGhlciBjb252
b2x1dGVkIGFuZCBoYXJkIHRvCj4+IHJlYWQgLSBib3RoIGJyYW5jaGVzIG9mIHRoZSBpZigpIGFj
dHVhbGx5IGRvIHRoZSBleGFjdCBzYW1lIHRoaW5nLiBTbwo+PiByZW1vdmUgdGhlIGlmKCksIGFu
ZCBmdXJ0aGVyIHNpbXBsaWZ5ICI8Ym9vbGVhbiBjb25kaXRpb24+ID8gdHJ1ZSA6Cj4+IGZhbHNl
IiB0byAiPGJvb2xlYW4gY29uZGl0aW9uPiIuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFJhc211cyBW
aWxsZW1vZXMgPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kaz4KPj4gLS0tCj4+IEkgc3R1bWJsZWQg
b24gdGhpcyB3aGlsZSB0cnlpbmcgdG8gdW5kZXJzdGFuZCBob3cgdGhlIHB3bSBzdWJzeXN0ZW0K
Pj4gd29ya3MuIFRoaXMgcGF0Y2ggaXMgYSBzZW1hbnRpYyBuby1vcCwgYnV0IGl0J3MgYWxzbyBw
b3NzaWJsZSB0aGF0LAo+PiBzYXksIHRoZSBmaXJzdCBicmFuY2ggc2ltcGx5IGNvbnRhaW5zIGEg
ImRvdWJsZSBuZWdhdGl2ZSIgc28gZWl0aGVyCj4+IHRoZSAhPSBzaG91bGQgYmUgPT0gb3IgdGhl
ICJmYWxzZSA6IHRydWUiIHNob3VsZCBiZSAidHJ1ZSA6IGZhbHNlIi4KPj4KPj4gICBkcml2ZXJz
L3B3bS9wd20tcm9ja2NoaXAuYyB8IDcgKy0tLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkKPiAKPiBJJ3ZlIGFwcGxpZWQgdGhpcy4gSXJyZXNw
ZWN0aXZlIG9mIGFueSBmZWVkYmFjayBEYXZpZCB3b3VsZCBoYXZlIHRoaXMgaXMKPiBjb3JyZWN0
IGFuZCBhIG5pY2Ugc2ltcGxpZmljYXRpb24uCj4gCj4gVGhpZXJyeQo+IAoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
