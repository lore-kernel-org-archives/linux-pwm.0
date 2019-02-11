From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management
 support
Date: Mon, 11 Feb 2019 14:21:25 +0100
Message-ID: <7abbd3e2-4a33-975a-39ee-dcf608633b36@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
 <20190209162133.65e6fd93@archlinux>
 <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan Cameron <jic23@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, vilhelm.gray@gmail.com, thierry.reding@gmail.com, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gMi8xMC8xOSAxMDozMyBQTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gT24gU2F0LCBG
ZWIgMDksIDIwMTkgYXQgMDQ6MjE6MzNQTSArMDAwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToK
Pj4gT24gVHVlLCA1IEZlYiAyMDE5IDEzOjQwOjI5ICswMTAwCj4+IEZhYnJpY2UgR2FzbmllciA8
ZmFicmljZS5nYXNuaWVyQHN0LmNvbT4gd3JvdGU6Cj4+Cj4+PiBBZGQgc3VzcGVuZC9yZXN1bWUg
UE0gc2xlZXAgb3BzLiBXaGVuIGdvaW5nIHRvIGxvdyBwb3dlciwgZGlzYWJsZQo+Pj4gYWN0aXZl
IGNvdW50ZXIuIE9ubHkgYWN0aXZlIGNvdW50ZXIgc2hvdWxkIGJlIHJlc3VtZWQ6IGRvbid0IHRv
dWNoCj4+PiBkaXNhYmxlZCBjb3VudGVyLCBhcyBpdCBtYXkgYmUgdXNlZCBieSBvdGhlciBMUFRp
bWVyIE1GRCBjaGlsZCBkcml2ZXIuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRmFicmljZSBHYXNu
aWVyIDxmYWJyaWNlLmdhc25pZXJAc3QuY29tPgo+PiBJIHRoaW5rIHRoaXMgbG9va3MgZmluZS4g
IEknbSBub3QgdG90YWxseSBzdXJlIGlmIHBhdGNoZXMgMyw0IGFyZQo+PiBzZXBhcmFibGUgZnJv
bSAxLDIgdGhvdWdoIHNvIHBsZWFzZSBsZXQgbWUga25vdyB3aGV0aGVyIEkgc2hvdWxkIHRha2UK
Pj4gdGhlc2Ugbm93LCBvciBsZXQgYWxsIDQgZ28gaW4gdG9nZXRoZXIgdmlhIHNvbWUgcGF0aD8K
PiAKPiBJJ2Qgc2F5IHRoZXNlIGFyZSBvcnRob2dvbmFsLCBzbyBpZiB5b3UgYXJlIGhhcHB5IHdp
dGggcGF0Y2hlcyAzIGFuZCA0Cj4geW91IGNhbiB0YWtlIHRoZW0gd2l0aG91dCBib3RoZXJpbmcg
Zm9yIHBhdGNoZXMgMSBhbmQgMi4KCkhpIFV3ZSwgSm9uYXRoYW4sCgpUaGFua3MgZm9yIHJldmll
d2luZy4gSSBjb25maXJtIHlvdSBjYW4gdGFrZSBwYXRjaGVzIDMgYW5kIDQuIEknbGwgc2VuZAph
IHYyIGZvciBwYXRjaGVzIDEgYW5kIDIgc2VwYXJhdGVseS4KCkJlc3QgcmVnYXJkcywKRmFicmlj
ZQoKPiAKPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
