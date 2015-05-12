From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Intel-gfx] [PATCH 1/8] drivers/gpio/gpiolib: Add support for
 removing registered consumer lookup table
Date: Tue, 12 May 2015 10:52:26 +0200
Message-ID: <CACRpkdY47b6mzrSk99AQ19MnQarCCKaKqTQLejMyJjxtpjd6qA@mail.gmail.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
 <1430316005-16480-2-git-send-email-shobhit.kumar@intel.com>
 <CACRpkdbtu_J2vCZ2kKVhBX6J0Ptgx0UvbJo3jSf8s=8E2qf-mw@mail.gmail.com>
 <20150506150949.GM30184@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150506150949.GM30184@phenom.ffwll.local>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Linus Walleij <linus.walleij@linaro.org>, Shobhit Kumar <shobhit.kumar@intel.com>, Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Johan Hovold <johan@kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCBNYXkgNiwgMjAxNSBhdCA1OjA5IFBNLCBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3
bGwuY2g+IHdyb3RlOgo+IE9uIFdlZCwgTWF5IDA2LCAyMDE1IGF0IDA0OjQ5OjM2UE0gKzAyMDAs
IExpbnVzIFdhbGxlaWogd3JvdGU6Cj4+IE9uIFdlZCwgQXByIDI5LCAyMDE1IGF0IDM6NTkgUE0s
IFNob2JoaXQgS3VtYXIgPHNob2JoaXQua3VtYXJAaW50ZWwuY29tPiB3cm90ZToKPj4KPj4gPiBJ
biBjYXNlIHdlIHVubG9hZCBhbmQgbG9hZCBhIGRyaXZlciBtb2R1bGUgYWdhaW4gdGhhdCBpcyBy
ZWdpc3RlcmluZyBhCj4+ID4gbG9va3VwIHRhYmxlLCB3aXRob3V0IHRoaXMgaXQgd2lsbCByZXN1
bHQgaW4gbXVsdGlwbGUgZW50cmllcy4gUHJvdmlkZQo+PiA+IGFuIG9wdGlvbiB0byByZW1vdmUg
dGhlIGxvb2t1cCB0YWJsZSBvbiBkcml2ZXIgdW5sb2FkCj4+ID4KPj4gPiB2MjogQ2NpbmcgbWFp
bnRhaW5lcnMKPj4gPgo+PiA+IENjOiBTYW11ZWwgT3J0aXogPHNhbWVvQGxpbnV4LmludGVsLmNv
bT4KPj4gPiBDYzogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgo+PiA+
IENjOiBBbGV4YW5kcmUgQ291cmJvdCA8Z251cm91QGdtYWlsLmNvbT4KPj4gPiBDYzogVGhpZXJy
eSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4KPj4gPiBSZXZpZXdlZC1ieTogQWxl
eGFuZHJlIENvdXJib3QgPGFjb3VyYm90QG52aWRpYS5jb20+Cj4+ID4gU2lnbmVkLW9mZi1ieTog
U2hvYmhpdCBLdW1hciA8c2hvYmhpdC5rdW1hckBpbnRlbC5jb20+Cj4+Cj4+IFJldmlld2VkLWJ5
OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Cj4KPiBJIHRoaW5rIHRo
ZSBncGlvL3B3bSBhbmQgbWZkIHBhcnRzIHdvdWxkIGFsbCBuZWVkIHRvIGdvIGluIHRocm91Z2gg
dGhlCj4gc2FtZSB0cmVlLiBpOTE1IHBhcnRzIGFyZSBkZWNvdXBsZWQuIEkgZ3Vlc3MgSSBjb3Vs
ZCBkbyBhIGJyYW5jaCB3aXRoIGp1c3QKPiB0aG9zZSBwYXRjaGVzLCB0YWcgaXQgYW5kIHRoZW4g
c2VuZCBhIHB1bGwgcmVxdWVzdCB0byBhbGwgMyBzdWJzeXN0ZW1zCj4gb25jZSBpdCdzIHJldmll
d2VkLiBXb3VsZCB0aGF0IGJlIG9rPwoKVGhhdCdzIGFuIGltbXV0YWJsZSBicmFuY2ggSSBndWVz
cywgYW5kIHllYWggSSB0aGluayBpdCdzIE9LLgpJIHVzdWFsbHkgb25seSBwdWxsIHRoZXNlIGlu
IGlmL3doZW4gdGhlcmUgYXJlIGNvbmZsaWN0cyBpbiAtbmV4dC4KCllvdXJzLApMaW51cyBXYWxs
ZWlqCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
