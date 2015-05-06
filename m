From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/8] drivers/gpio/gpiolib: Add support for
 removing registered consumer lookup table
Date: Wed, 6 May 2015 16:49:36 +0200
Message-ID: <CACRpkdbtu_J2vCZ2kKVhBX6J0Ptgx0UvbJo3jSf8s=8E2qf-mw@mail.gmail.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
 <1430316005-16480-2-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1430316005-16480-2-git-send-email-shobhit.kumar@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Johan Hovold <johan@kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCBBcHIgMjksIDIwMTUgYXQgMzo1OSBQTSwgU2hvYmhpdCBLdW1hciA8c2hvYmhpdC5r
dW1hckBpbnRlbC5jb20+IHdyb3RlOgoKPiBJbiBjYXNlIHdlIHVubG9hZCBhbmQgbG9hZCBhIGRy
aXZlciBtb2R1bGUgYWdhaW4gdGhhdCBpcyByZWdpc3RlcmluZyBhCj4gbG9va3VwIHRhYmxlLCB3
aXRob3V0IHRoaXMgaXQgd2lsbCByZXN1bHQgaW4gbXVsdGlwbGUgZW50cmllcy4gUHJvdmlkZQo+
IGFuIG9wdGlvbiB0byByZW1vdmUgdGhlIGxvb2t1cCB0YWJsZSBvbiBkcml2ZXIgdW5sb2FkCj4K
PiB2MjogQ2NpbmcgbWFpbnRhaW5lcnMKPgo+IENjOiBTYW11ZWwgT3J0aXogPHNhbWVvQGxpbnV4
LmludGVsLmNvbT4KPiBDYzogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3Jn
Pgo+IENjOiBBbGV4YW5kcmUgQ291cmJvdCA8Z251cm91QGdtYWlsLmNvbT4KPiBDYzogVGhpZXJy
eSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4KPiBSZXZpZXdlZC1ieTogQWxleGFu
ZHJlIENvdXJib3QgPGFjb3VyYm90QG52aWRpYS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hvYmhp
dCBLdW1hciA8c2hvYmhpdC5rdW1hckBpbnRlbC5jb20+CgpSZXZpZXdlZC1ieTogTGludXMgV2Fs
bGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgoKU2luY2UgaXQgaXMgY29yZSBzdXBwb3J0
IEknZCBwcmVmZXIgdG8gbWVyZ2UgdGhpcyBpbnRvIHRoZSBHUElPIGdpdAp0cmVlLiBJcyBpdCBP
SyBvciBkbyB5b3UgbmVlZCB0byBtZXJnZSBpdCB0aHJvdWdoIHNvbWUgb3RoZXIgbWVhbnM/CgpZ
b3VycywKTGludXMgV2FsbGVpagpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lu
dGVsLWdmeAo=
