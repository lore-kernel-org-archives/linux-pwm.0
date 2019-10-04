From: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [Linux-stm32] [PATCH] pwm: stm32: Fix the usage of uninitialized
 variable in stm32_pwm_config()
Date: Fri, 4 Oct 2019 09:09:51 +0000
Message-ID: <e6824330-d331-798d-0f0a-1952db028900@st.com>
References: <20191004044649.2405-1-yzhai003@ucr.edu>
 <20191004062336.jidzrytx4z5talro@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191004062336.jidzrytx4z5talro@pengutronix.de>
Content-Language: en-US
Content-ID: <9356118905A9F942ADA617A804B4486F@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Yizhuo <yzhai003@ucr.edu>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Fabrice GASNIER <fabrice.gasnier@st.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

DQpPbiAxMC80LzE5IDg6MjMgQU0sIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxsbywN
Cj4NCj4gT24gVGh1LCBPY3QgMDMsIDIwMTkgYXQgMDk6NDY6NDlQTSAtMDcwMCwgWWl6aHVvIHdy
b3RlOg0KPj4gSW5zaWRlIGZ1bmN0aW9uIHN0bTMyX3B3bV9jb25maWcoKSwgdmFyaWFibGUgInBz
YyIgYW5kICIgYXJyIg0KPj4gY291bGQgYmUgdW5pbml0aWFsaXplZCBpZiByZWdtYXBfcmVhZCgp
IHJldHVybnMgLUVJTlZBTHMuDQo+PiBIb3dldmVyLCB0aGV5IGFyZSB1c2VkIGxhdGVyIGluIHRo
ZSBpZiBzdGF0ZW1lbnQgdG8gZGVjaWRlDQo+PiB0aGUgcmV0dXJuIHZhbHVlIHdoaWNoIGlzIHBv
dGVudGlhbGx5IHVuc2FmZS4NCg0KSGkgWWl6aHVvLA0KDQpsaWtlIGZvciB0aGUgeW91ciBwYXRj
aCBpbiBJSU8gdHJpZ2dlciByZWdtYXBfcmVhZCBjb3VsZCBvbmx5IGZhaWxlZA0KaWYgdGhlIGhh
cmR3YXJlIGJsb2NrIGlzIG5vIG1vcmUgY2xvY2tlZCBhbmQgaW4gdGhpcyBjYXNlIHdlIHdvbid0
IA0KcmV0dXJuIG9mIHJlZ21hcF9yZWFkLg0KVGVzdGluZyByZWdtYXBfcmVhZCgpIHJldHVybiB2
YWx1ZSBqdXN0IGFkZCBjb2RlIGJ1dCBkb2Vzbid0IHByb3ZpZGUgYSANCnZhbGlkIGluZm9ybWF0
aW9uLg0KSWYgeW91IHJlYWxseSB3YW50IHRvIGxvZyBhbGwgdGhlIHBvc3NpYmxlIGVycm9ycyBj
YXNlcyBwbGVhc2UgZG8gaXQgaW4gDQpyZWdtYXAgY29kZSBpdHNlbGYgYW5kDQpub3QgaW4gKmFs
bCogdGhlIGRyaXZlcnMuDQoNClRoYW5rcywNCg0KQmVuamFtaW4NCg0KPj4NCj4+IFRoZSBzYW1l
IGNhc2UgaGFwcGVucyBpbiBmdW5jdGlvbiBzdG0zMl9wd21fZGV0ZWN0X2NoYW5uZWxzKCkNCj4+
IHdpdGggdmFyaWFibGUgImNjZXIiLCBidXQgd2UgY2Fubm90IGp1c3QgcmV0dXJuIC1FSU5WQUwg
YmVjYXVzZQ0KPj4gdGhlIGVycm9yIGNvZGUgaXMgbm90IGFjY2VwdGFibGUgYnkgdGhlIGNhbGxl
ci4gQXNsbywgdGhlIHZhcmlhYmxlDQo+IHMvQXNsby9BbHNvLw0KPg0KPj4gImNjZXIiIGluIGZ1
bmN0aW9uc3RtMzJfcHdtX2RldGVjdF9jb21wbGVtZW50YXJ5KCkgY291bGQgYWxzbyBiZQ0KPiBz
L2Z1bmN0aW9uc3RtMzJfcHdtX2RldGVjdF8vZnVuY3Rpb24gc3RtMzJfcHdtX2RldGVjdF8vDQo+
DQo+PiB1bmluaXRpYWxpemVkLCBzaW5jZSBzdG0zMl9wd21fZGV0ZWN0X2NvbXBsZW1lbnRhcnko
KSByZXR1cm5zIHZvaWQsDQo+PiB0aGUgcGF0Y2ggaXMgbm90IGVhc3kuDQo+IGFjdGl2ZV9jaGFu
bmVscygpIGlzIGFsc28gYWZmZWN0ZWQuIEFsc28gdGhlcmUgYXJlIGNhbGxzIHRvDQo+IHJlZ21h
cF91cGRhdGVfYml0cyB3aGljaCBzaG91bGQgaGF2ZSB0aGVpciByZXR1cm4gdmFsdWVzIGNoZWNr
ZWQuDQo+DQo+IFdoaWxlIGEgcGF0Y2ggdG8gZml4IHRoZXNlIGFsbCBpcyBub3QgdHJpdmlhbCBp
dCBpcyBjZXJ0YWlubHkgcG9zc2libGUNCj4gYW5kIEkgd291bGQgcHJlZmVyIHRvIGZpeCB0aGUg
cHJvYmxlbSBjb21wbGV0ZWx5Lg0KPg0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
